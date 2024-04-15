#!/usr/bin/env bash

clear;

sudo aura -Syyu

# -t emacs-29
pushd $HOME/system_scripts/ || exit 1

clear; ./build-emacs.sh -t master -p 20 &&

pushd $HOME/SourceCode/emacs/ || exit 1

./src/emacs --version &&
    git log

