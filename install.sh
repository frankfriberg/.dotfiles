#!/usr/bin/env bash

# Homebrew
if which brew >/dev/null; then
    read -p "Install Homebrew packages? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew bundle --file "$CWD/Brewfile"
    fi
else
    printf "\nHomebrew not installed! Skipping package installation..\n\n"
fi


