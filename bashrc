#!/bin/bash
# ~/.bashrc
#
echo "I'm .bashrc"

[[ $- != *i* ]] && return

[[ -f ~/.Xresources ]] && xrdb -load ~/.Xresources

alsi -a -u

# Config bash history
export HISTSIZE=100000            # big history
export HISTFILESIZE=100000        # big history
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
#HISTCONTROL=ignoredups:erasedups # no duplicates, erase already dupes
shopt -s histappend # append to history, don't overwrite it

# cool prompt
PS1='$(tput setaf 4)\u$(tput setaf 7)@$(tput setaf 2)\h$(tput sgr0):> '

# auto change directory
shopt -s autocd

# bind history search to page up/down keys
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# Funcs to help with stuff
# NOTE: 0 is true
prog_exists ()
{
  command -v $1 > /dev/null 2>&1 || { return 1; }
  return 0
}

source_file ()
{
  if [ -f $1 ] ; then
    source $1
  else
    echo "$1 doesn't exist to source."
  fi
}

add_path ()
{
  if [ -d $1 ] ; then
    PATH=$PATH:$1
  else
    echo "$1 doesn't exist to add to path."
  fi
}

#turn on numlock
if ! prog_exists numlockOnTty ; then
  setleds -D +num
  echo "Install systemd-numlockontty from aur and enable it to get rid of this error"
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Source some files
source_file /usr/share/chruby/chruby.sh

# Path some stuff

# Add RVM to PATH for scripting
add_path $HOME/.rvm/bin

#android tools
add_path /opt/android-sdk/tools
add_path /opt/android-sdk/platform-tools

# nodejs stuff
if prog_exists npm ; then
  add_path $(npm bin)
  add_path $(npm bin -g)
else
  echo "npm isn't installed"
fi

# Colorize commands
alias ls='ls --color=auto'
## Use a long listing format ##
alias ll='ls -la'
## Show hidden files ##
alias l.='ls -d .*'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

if prog_exists colordiff ; then
  alias diff='colordiff'
else
  echo 'Install colordiff, fool'
fi

if prog_exists htop ; then
  alias top='htop'
else
  echo 'Install htop, fool'
fi

# Everlane stuff - thanks taylor
alias ever-t='bundle exec bin/rspec spec'
alias ever-c='bundle exec bin/rails c'
alias ever-s='bundle exec bin/rails s'
alias ever-r='bundle exec bin/rake'

# git it, boy - thanks again, taylor
alias git-branch='git branch | cut -c 3- | selecta | xargs git checkout'
alias c='clear'
## get rid of command not found ##
alias cd..='cd ..'
## Colorize the grep command output for ease of use (good for log files)##
# Create a new set of commands
alias path='echo -e ${PATH//:/\\n}'
alias now='date +%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
#11: Control output of networking tool called ping
# Stop after sending count ECHO_REQUEST packets #
# Do not wait interval 1 second, go fast #
alias ping='ping -c 5 -i .2'
#12: Show open ports
alias ports='netstat -tulanp'

