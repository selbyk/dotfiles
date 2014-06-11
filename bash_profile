#!/bin/sh
# ~/.bash_profile
#
echo "I'm .bash_profile"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.Xresources ]] && xrdb -load ~/.Xresources
[[ -f ~/.bashrc ]] && source ~/.bashrc
