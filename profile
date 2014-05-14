#!/bin/sh
# ~/.profile
#
echo "I'm .profile"

[[ -f ~/.Xresources ]] && xrdb -override ~/.Xresources

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
