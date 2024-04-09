#!/usr/bin/env bash

clear;

sudo aura -Syyu

# -t emacs-29
cd; clear; ./build-emacs.sh -t master -p 20 &&

    cd ~/SourceCode/emacs/

./src/emacs --version &&
    git log

