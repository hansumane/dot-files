export PS1="(chr) $PS1"
export PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin'

alias q='exit'
alias rr='rm -rf'
alias ls='LC_COLLATE=C ls --color'
alias cpwd="c;echo -n 'PWD in ';pwd"

alias la='ls -A'
alias ll='ls -alh'
alias lx='ls -Alh'
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

export EDITOR='vi'
v () {
	"$EDITOR" $@
	rm -rf "$HOME/.cache/ctrlp/" "$HOME/.vifm/" "$HOME/.viminfo"
}

export REAL_LESS="$(readlink -f $(which less))"
less () {
	"$REAL_LESS" $@
	rm -rf "$HOME/.lesshst"
}

c () {
  if command -v clear > /dev/null 2>&1 ; then
    clear
  else
    printf '\ec\e[2J\e[H'
  fi
}

_hxl () {
  for f in $@ ; do
    echo "$f"
    hexdump -vC "$f"
  done
}

hxl () {
  _hxl $@ | less --tabs=8
}

bind 'TAB:menu-complete'
bind 'set completion-ignore-case on'
