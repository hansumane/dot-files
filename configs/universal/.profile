#
# .profile - the simpliest shell init
#

if [ $EUID -eq 0 ]; then
  PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

export EDITOR='vi'
alias v="$EDITOR"

alias q='exit'
alias rr='rm -rf'
alias c='if command -v clear > /dev/null 2>&1; then clear; else printf "\033[H\033[J"; fi'

alias cpwd="c;echo -n 'PWD in ';pwd"
alias la='ls -A'
alias ll='ls -alh'
alias lx='ls -Alh'
alias lt='tree'
alias cla='cpwd;la'
alias cll='cpwd;ll'
alias clx='cpwd;lx'
alias cxl='cpwd;lx'
alias clt='cpwd;lt'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
