export PS1='\u@\h:\w\$ '
export TERM='xterm-256color'
export EDITOR='nvim'
TOPATH="$HOME/.local/bin $HOME/.cargo/bin"

alias q='exit'
alias t='c;tmux'
alias rr='rm -rf'
alias c="clear;echo '( ,-,)'"

alias ls='LANG=en_US.UTF-8 ls'
alias cpwd="clear;echo -n 'PWD in ';pwd"

alias la='ls -A'
alias ll='ls -alh --classify --group-directories-first'
alias lx='ls -Alh --no-group --classify --group-directories-first'
alias cla='cpwd;la'
alias cll='cpwd;ll'
alias clx='cpwd;lx'
alias clt='cpwd;lt'

alias gite='gitr && ..'
alias gits='git status'
alias gitr='cd $(git rev-parse --show-toplevel)'
alias gitl='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gitp='git reset --hard HEAD'
alias gitp^='git reset --hard HEAD^'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

lt () {
  if [[ $# -eq 0 ]]; then
    tree --dirsfirst .
  elif [[ $# -eq 1 ]]; then
    case $1 in
      [0-9] ) tree --dirsfirst -L $1;;
      * ) tree --dirsfirst $1;;
    esac
  else
    case $1 in
      [0-9] ) tree --dirsfirst -L $1 $2;;
      * ) tree --dirsfirst -L $2 $1;;
    esac
  fi
}

gitup () {
  if [[ $# -eq 0 ]]; then
    read -p 'No commit name given, git pull? [Y/n] ' ANS
    case $ANS in
      [Nn] ) echo 'Exiting...';;
      *    ) git pull; git status;;
    esac
  else
    git add -A
    git commit -m "$1"
    read -p 'Commit name given, git push? [Y/n] ' ANS
    case $ANS in
      [Nn] ) echo 'Exiting...';;
      *    ) git push; git status;;
    esac
  fi
}

bless () {
  if [[ $# -eq 0 ]]; then
    echo 'Error: No source file given!'; return 1
  else
    cat -n $1 | less
  fi
}

indchk () {
  if [[ $# -eq 0 ]]; then
    echo 'Error: No source file given!'; return 1
  else
    indent -gnu -nut -npcs $1 -o $1\~ &&
    diff -u $1 $1\~ | cat -n | less
    rm -rf $1\~
  fi
}

edP () {
  if [[ $# -eq 0 ]]; then
    echo 'Error: No file name given!'; return 1
  else
    if [[ ! -f $1 ]]; then
      touch $1 && chmod +x $1 && echo "#!/bin/env python3\n\nif __name__ == '__main__':\n    pass" > $1 && $EDITOR $1
    else
      $EDITOR $1
    fi
  fi
}

fcc () {
  if [[ $# -eq 0 ]]; then
    echo 'Error: No source file(s) given!'; return 1
  else
    gcc $@ -std=gnu99 -Wall -Wextra -O2 -o out-$(basename $1 .c)
  fi
}

fcp () {
  if [[ $# -eq 0 ]]; then
    echo 'Error: No source file(s) given!'; return 1
  else
    clang++ $@ -Wall -Wextra -O2 -o out-$(basename $1 .cpp)
  fi
}

frs () {
  if [[ $# -eq 0 ]]; then
    echo 'Error: No source file(s) given!'; return 1
  else
    rustc $@ -C debuginfo=0 -C opt-level=2 -o out-$(basename $1 .rs)
  fi
}

# bind 'TAB:menu-complete'
# bind 'set completion-ignore-case on'
# bind 'set show-all-if-ambiguous on'

for DIR in $TOPATH; do
  if [[ -d $DIR ]]; then
    case :$PATH: in
      *:$DIR:* ) ;;
      * ) export PATH=$PATH:$DIR;;
    esac
  fi
done
c
