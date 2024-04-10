# -*- mode: Shell; -*-
# .zshrc

autoload -U compinit promptinit
compinit
promptinit
# prompt gentoo

#UAE envars
SDL_VIDEO_X11_XRANDR=1

ZSH_THEME="fox"

zstyle ':completion::complete:*' use-cache 1

unset SBCL_HOME
export SBCL_HOME=/usr/local/lib/sbcl/

export LANG="en_US.UTF-8"
export LC_LOCALE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# big history file
HISTFILE=~/.zhistory
HISTSIZE=1000000
SAVEHIST=1000000


# User specific aliases and functions

## EXPORTS #####################################################

PATH="$HOME/system_scripts:$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/racket/bin:$PATH"
export PATH="/opt/e17/bin:$PATH"

export PYTHONPATH="/opt/e17/lib/python2.7/site-packages:$PYTHONPATH"

#export LESS="-j2 -i -a -c -h6 -q -P[?f%f:|.]?m-[%i of %m].?x-[next\: %x]. (%b?B/%B.B)-(%l?B/%L.L)?L %pB\%."
export PAGER=most
export CVS_RSH=ssh
export MAIL='~/Maildir/'
export NNTP='nntp.netcom.ca'
## web proxy setup
# export http_proxy=http://127.0.0.1:3129/
export FREEGUIDE_OPTS="-DproxySet=true -DproxyHost=http://127.0.0.1 -DproxyPort=3129"

# Guix requires certain state to function 
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

## tech.coop vacation messenger host
# alias vacat='ssh -l mailmon 74.115.254.23'

bindkey -e                # Emacs-style keybindings
setopt appendhistory      # append to HISTFILE
setopt autocd             # go to directories without "cd"
setopt extendedglob       # wacky zsh-specific pattern matching
setopt nocheckjobs        # don't complain about background jobs on exit
setopt nohup              # don't kill background jobs on exit
setopt printexitvalue     # print exit value from jobs
setopt noautoremoveslash
autoload -U select-word-style
select-word-style bash    # make word boundaries and stuff work like Bash

# cache completions (useful for apt/dpkg package completions)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# complete SSH hosts
local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts


# # Here's an annoying thing.  if xemacs' TMPDIR doesn't match gnuclient's
# # TMPDIR, gnuclient is unable to connect with xemacs. perhaps because it
# # relies on a file in $TMPDIR for ipc.
# # export TMPDIR=/usr/tmp

# # tramp does not like fancy prompts

# if [ "$TERM" = "dumb" ]
# then
#     unsetopt zle
#     unsetopt prompt_cr
#     unsetopt prompt_subst
# #    unfunction precmd
# #    unfunction preexec
#     PS1='$ '
# fi


export PROMPT=$'[%n]%B%M%b\:%~\n[%D{%a %b %d} <%*>]\\\>'

export WORDCHARS="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"

## eval `dircolors ~/.dircolors`

## ALIASES ######################################################

## alias ccl='/usr/local/bin/ccl64'
alias ls='ls -F'
alias la='ls -l'
alias ll='ls -la --color'
alias ltr='ls -ltr'
alias lsk='ls -l | sort -n -k 5'
alias ll='ls -l --color=auto'
alias lh='ls -h --color=auto'
alias llh='ls -lh --color=auto'
alias ec='emacsclient -c'
alias et='emacsclient -t'

## lisp stuff

alias refreeze="cd&&touch sbcl.core&&rm sbcl.core&&clear&&sbcl --eval '(freeze-sbcl)'"

## emacs setup for gnuclient because of the above aliases
export ALTERNATE_EDITOR=emacs
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -c'


alias rgrep='rgrep'
alias ffind='find . -type f -name'
alias dfind='find . -type d -name'
alias sauce='source ~/.zshrc'
alias rescreen='screen -D -r'
alias ssh='ssh -C'
alias j='jobs -l'

alias odeon='ssh -l fade -X 192.168.1.67'
alias digi='ssh -l root api.dev2.digisphereinc.com'
alias vex='ssh shell.vex.net'
alias vader='ssh vader.deepsky.com'
alias outrider='ssh outrider.deepsky.com'
alias lowry='ssh -p 9022 fade@70.27.93.116'
alias boba='ssh boba.deepsky.com'
alias wookiee='ssh wookiee'
alias maul='ssh deepsky.com'
alias corl='ssh coruscant.deepsky.com -L4005:localhost:4005'
alias cor='mosh fade@coruscant.deepsky.com'
alias silver='ssh silver.teardrop.org'
alias media='lftp sftp://fade@mortar.walled.net:/home/fade/media/'
alias mortar='ssh mortar.walled.net'
alias lilith='ssh lilith.icomm.ca'

### cicada hosts
alias r2='ssh 198.96.119.201'
alias r3='ssh ec2-184-73-118-130.compute-1.amazonaws.com'
alias r4='ssh 64.119.212.191'
alias r4ha='ssh 64.119.212.190'
alias r4pg='ssh 64.119.212.192'
alias r5='ssh 198.96.117.145'
alias r5pg='ssh 198.96.117.146'

## PROJECT ALIASES #############################################
export src='~/SourceCode'
alias mb='cd $src/MaggotSpork/agents/package/'
alias sr='cd $src/SR2-rewrite'
alias dg='cd $src/avt-web3'
alias lisp='cd $src/lisp/'

# requick () {
#       cd &&
#       if [ -f ~/quicklisp.lisp ] ; then
#  then
#       rm ~/quicklisp.lisp
#       wget http://beta.quicklisp.org/quicklisp.lisp && sbcl --no-userinit --load quicklisp.lisp'
# }

purify (){
rm -rf ~/.cache/common-lisp/* && rm -rf ~/.slime/fasl/*
}

ex () {
  if [ -f $1 ] ; then
  case $1 in
      *.tar.bz2)   tar xvjf $1        ;;
      *.tar.gz)    tar xvzf $1     ;;
      *.bz2)       bunzip2 $1       ;;
      *.rar)       rar x $1     ;;
      *.gz)        gunzip $1     ;;
      *.tar)       tar xvf $1        ;;
      *.tbz2)      tar xvjf $1      ;;
      *.tgz)       tar xvzf $1       ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1    ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
  esac

  else
      echo "'$1' is not a valid file"
  fi
}

settitle () {
    printf "\033]0..2;$1^G"
}

function rgrep () {
    local opts
    local search
    local dirs

    while [[ $1 = -* ]]
    do
        opts=($opts[@] $1)
        shift
    done

    search=$1
    shift

    if [ $#argv -gt 0 ]; then
        dirs=($@)
    else
        dirs=(".")
    fi

    find $dirs[@] -type f -print | xargs fgrep $opts[@] $search
}


## MISC FUNCTIONS ##############################################

# function setup_umodunpack_env () {
#     echo "Setting up umodpack environment ..."
#     export CVS_RSH=ssh
#     export CVSROOT=misaka@cvs.umodpack.sourceforge.net:/cvsroot/umodpack
# }

function lsd () {
    for i in *
    do
        if [ -d $i ]
        then
            ls -ald --color $i
        fi
    done
}

#directory tree please:
function lstree() {
echo
if [ "$1" != "" ]  #if parameter exists, use as base folder
   then cd "$1"
   fi
pwd
ls -R | grep ":$" |   \
   sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
# 1st sed: remove colons
# 2nd sed: replace higher level folder names with dashes
# 3rd sed: indent graph three spaces
# 4th sed: replace first dash with a vertical bar
if [ `ls -F -1 | grep "/" | wc -l` = 0 ]   # check if no folders
   then echo "   -> no sub-directories"
   fi
echo
}


## COMPLETION #####################################################
# The following lines were added by compinstall

zstyle ':completion:*' completer _oldlist _expand _complete _correct _approximate _prefix
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=1
zstyle ':completion:*' prompt 'please try again (%e): '
zstyle :compinstall filename '~/.zshrc'

autoload -U compinit
compinit
# End of lines added by compinstall

## HISTORY ########################################################
set HISTSIZE=100
set SAVEHIST=4000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY


## MINOR HACKS ####################################################
# Minor additions made for needs that can't easily be solved elegantly
# in other ways.  These hacks are usually for very specific tasks.

# Classbar-related hacks.
# cbdist() {  scp $* maul:public_html/class/  }

bigsbcl (){
numactl --interleave all sbcl --dynamic-space 4000 --eval "(rr)"
}

kobo (){
     sudo vpnc carpathia;
     sudo vpnc --local-port=0 kobo;
}
