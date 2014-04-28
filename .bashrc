#!/bin/bash
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alsi -a

# Config bash history
export HISTSIZE=100000 		# big history
export HISTFILESIZE=100000		# big history
PROMPT_COMMAND='history -a'	# write history immeddiately
shopt -s histappend 			 # append to history, don't overwrite it

# bind history search to page up/down keys
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

#turn on numlock
setleds -D +num

# auto change directory
shopt -s autocd

# Do some aliasing
alias ls='ls --color=auto'
PS1='\u@\h:$>'

# Everlane stuff - thanks taylor
alias ever-t='bundle exec bin/rspec spec'
alias ever-c='bundle exec bin/rails c'
alias ever-s='bundle exec bin/rails s'
alias ever-r='bundle exec bin/rake'

# git it, boy - thanks again, taylor
alias git-branch='git branch | cut -c 3- | selecta | xargs git checkout'

# Funcs to help with sourcing and pathing
# NOTE: 0 is true
prog_exists ()
{
	command -v $1 >/dev/null 2>&1 || { return 1; }
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
	echo "npm isn't installed, bro"
fi
