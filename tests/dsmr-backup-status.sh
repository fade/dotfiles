#!/usr/bin/env bash
# Check the status file dsmr-backup leaves behind, against a stub borg.
#
# Usage: tests/dsmr-backup-status.sh   (from the chezmoi source directory)
# Needs chezmoi to render the template. Exits non-zero on the first failure.
set -euo pipefail

src="$(cd "$(dirname "$0")/.." && pwd)/dot_local/bin/executable_dsmr-backup.tmpl"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

home="$work/home"
mkdir -p "$home/.config/borg" "$work/bin"
echo secret > "$home/.config/borg/passphrase"
echo "$work" > "$home/.config/borg/include"
: > "$home/.config/borg/exclude"

# Render with the home directory pointed at the sandbox.
sed "s|{{ .chezmoi.homeDir }}|$home|g" "$src" | chezmoi execute-template > "$work/dsmr-backup"
chmod +x "$work/dsmr-backup"

# Stub borg. FAKE_CREATE_RC sets the exit status of create, FAKE_CREATE_SLEEP
# how long create runs; create writes one stderr line before it sleeps.
cat > "$work/bin/borg" <<'EOF'
#!/usr/bin/env bash
case "$1" in
    create)
        echo "borg: create started" >&2
        : > "$FAKE_MARK"
        sleep "${FAKE_CREATE_SLEEP:-0}"
        [ "${FAKE_CREATE_RC:-0}" -lt 2 ] || echo "borg: repository does not exist" >&2
        exit "${FAKE_CREATE_RC:-0}" ;;
    *) exit 0 ;;
esac
EOF
chmod +x "$work/bin/borg"

export PATH="$work/bin:$PATH" XDG_STATE_HOME="$work/state" FAKE_MARK="$work/mark"
status="$work/state/dsmr-backup/status"
fails=0

field() { sed -n "s/^$1=//p" "$status"; }

expect() {
    local name=$1 want_state=$2 want_rc=$3 want_step=$4 got
    got="$(field state) $(field rc) $(field step)"
    if [ "$got" = "$want_state $want_rc $want_step" ]; then
        echo "ok   $name"
    else
        echo "FAIL $name: want '$want_state $want_rc $want_step', got '$got' ($(field message))"
        fails=$((fails + 1))
    fi
}

reset() { rm -f "$status" "$FAKE_MARK" "$work/stderr"; }

# Start a run in its own process group, wait for create to begin, then signal.
# $1 is the kill target: "group" or "script".
killed_run() {
    reset
    FAKE_CREATE_SLEEP=$2 setsid "$work/dsmr-backup" 2> "$work/stderr" &
    local pid=$!
    for _ in $(seq 100); do [ -e "$FAKE_MARK" ] && break; sleep 0.05; done
    sleep 0.1
    if [ "$1" = group ]; then kill -TERM -- "-$pid"; else kill -TERM "$pid"; fi
    wait "$pid" || true
}

reset; "$work/dsmr-backup" 2>/dev/null
expect "clean run" ok 0 compact

reset; FAKE_CREATE_RC=1 "$work/dsmr-backup" 2>/dev/null
expect "borg warning" ok 1 compact

reset; FAKE_CREATE_RC=2 "$work/dsmr-backup" 2>/dev/null || true
expect "create fails" failed 2 create
[ "$(field message)" = "borg: repository does not exist" ] \
    || { echo "FAIL create fails: message is '$(field message)'"; fails=$((fails + 1)); }

killed_run group 30
expect "TERM to process group mid-create" failed 143 create
if grep -q 'create started' "$work/stderr"; then
    echo "ok   borg stderr reaches the journal on a killed run"
else
    echo "FAIL borg stderr lost on a killed run"; fails=$((fails + 1))
fi

killed_run script 1
expect "TERM to the script alone mid-create" failed 143 create

reset; rm "$home/.config/borg/passphrase"
"$work/dsmr-backup" 2>/dev/null || true
expect "no passphrase" failed 1 setup

if [ "$fails" -ne 0 ]; then
    echo "$fails failed"; exit 1
fi
echo "all passed"
