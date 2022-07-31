export TERM='xterm-256color'
export EDITOR='nvim'
export ZSH="$HOME/.oh-my-zsh"
# export EXA_COLORS='di=1;35:da=0;35'

FOLDER_ICON='  '
EXA_ICONS='--icons'
SYS_FETCH='neofetch'
ZSH_THEME='awesomepanda'
TOPATH="$HOME/.local/bin $HOME/.cargo/bin"

plugins=(git svn zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias q='exit'
alias t='c;tmux'
alias rr='rm -rf'
alias c="clear;echo '( .-.)'"
alias cpwd="clear;echo -n '${FOLDER_ICON}PWD in ';pwd"

alias la='exa -a'
alias ll="exa $EXA_ICONS -albh --group-directories-first"
alias lx="exa $EXA_ICONS -albh --no-user --group-directories-first"
alias cla='cpwd;la'
alias cll='cpwd;ll'
alias clx='cpwd;lx'
alias clt='cpwd;lt'

alias gits='git status'
alias gitr='cd $(git rev-parse --show-toplevel)'
alias gitl='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

alias fetch="c;$SYS_FETCH"
alias edM="$EDITOR Makefile"
alias edrc="$EDITOR ~/.zshrc && . ~/.zshrc"

alias updg='pkg upgrade -y && apt update && apt full-upgrade -y'
alias upcl='pkg autoclean -y && apt autoremove -y && apt autoclean -y'
alias updc='updg && upcl'

lt () {
  if [[ $# -eq 0 ]]; then
    exa $EXA_ICONS --group-directories-first -aT
    tree --dirsfirst -A .
  elif [[ $# -eq 1 ]]; then
    case $1 in
      [0-9] ) exa $EXA_ICONS --group-directories-first -aT --level $1;;
      * ) exa $EXA_ICONS --group-directories-first -aT $1;;
    esac
  else
    case $1 in
      [0-9] ) exa $EXA_ICONS --group-directories-first -aT --level $1 $2;;
      * ) exa $EXA_ICONS --group-directories-first -aT --level $2 $1;;
    esac
  fi
}

gitup () {
  if [[ $# == 0 ]]; then
    if read -q 'choice?No commit name given, git pull? '; then
      echo ''; git pull --rebase; git status
    else
      echo ' Exiting...'
    fi
  else
    git add -A; git commit -m$1
    if read -q 'choice?Commit name given, git push? '; then
      echo ''; git push; git status
    else
      echo ' Exiting...'
    fi
  fi
}

fcc () {
  if [[ $# == 0 ]]; then
    echo 'error: no source file(s) given!'; return 1
  else
    gcc $@ -std=gnu99 -Wall -Os -o out-$(basename $1 .c)
  fi
}

fcp () {
  if [[ $# == 0 ]]; then
    echo 'error: no source file(s) given!'; return 1
  else
    clang++ $@ -Wall -Os -o out-$(basename $1 .cpp)
  fi
}

setopt shwordsplit
for DIR in $TOPATH; do
  if [ -d $DIR ]; then
    case ":$PATH:" in
      *:"$DIR":* ) ;;
      * ) export PATH="$PATH:$DIR";;
    esac
  fi
done
