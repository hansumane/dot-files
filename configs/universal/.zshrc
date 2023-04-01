export TERM='xterm-256color'
export EDITOR='nvim'
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_us=$'\e[01;37m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

SUDO_CMD='sudo'
FOLDER_ICON='  '
EXA_ICONS='--icons'
ZSH_THEME='undollar'
LOCAL_LANG='LANG=en_US.UTF-8'
TOPATH="$HOME/.local/bin $HOME/.cargo/bin"

plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias q='exit'
alias t='c;tmux'
alias rr='rm -rf'
alias rrs="$SUDO_CMD rm -rf"
alias c="clear;echo '( ,-,)'"

alias exa="$LOCAL_LANG exa"
alias cpwd="clear;echo -n '${FOLDER_ICON}PWD in ';pwd"

alias la='exa -a'
alias ll="exa $EXA_ICONS -albh --git --classify --group --group-directories-first"
alias lx="exa $EXA_ICONS -albh --git --classify --no-user --group-directories-first"
alias cla='cpwd;la'
alias cll='cpwd;ll'
alias clx='cpwd;lx'
alias clt='cpwd;lt'
alias cxl='clx'

alias sbn="$SUDO_CMD reboot"
alias sdn="$SUDO_CMD poweroff"

alias gite='gitr && ..'
alias gits='git status'
alias gitr='cd $(git rev-parse --show-toplevel)'
alias gitl='git log --date=format-local:"%d/%m/%Y %H:%M:%S" --pretty=format:"%h %ad | %an >>> %s%d" --graph'
alias gitp='git reset --hard HEAD'
alias gitp^='git reset --hard HEAD^'

alias edM="$EDITOR Makefile"
alias edrc="$EDITOR ~/.zshrc && . ~/.zshrc"

lt () {
  if (( $# == 0 )); then
    exa $EXA_ICONS --group-directories-first --tree
  elif (( $# == 1 )); then
    case $1 in
      [0-9] ) exa $EXA_ICONS --group-directories-first --tree --level $1;;
      * ) exa $EXA_ICONS --group-directories-first --tree $1;;
    esac
  else
    case $1 in
      [0-9] ) exa $EXA_ICONS --group-directories-first --tree --level $1 $2;;
      * ) exa $EXA_ICONS --group-directories-first --tree --level $2 $1;;
    esac
  fi
}

gitup () {
  if (( $# == 0 )); then
    read 'ANS?No commit name given, git pull? [Y/n] '
    case $ANS in
      [Nn] ) echo 'Exiting...';;
      *    ) git pull; git status;;
    esac
  else
    git add -A
    git commit -m "$1"
    read 'ANS?Commit name given, git push? [Y/n] '
    case $ANS in
      [Nn] ) echo 'Exiting...';;
      *    ) git push; git status;;
    esac
  fi
}

bless () {
  if (( $# == 0 )); then
    echo 'Error: No source file given!'; return 1
  else
    cat -n $1 | less
  fi
}

indchk () {
  if (( $# == 0 )); then
    echo 'Error: No source file given!'; return 1
  else
    indent -gnu -nut $1 -o $1\~ &&  # -npcs
    diff -u $1 $1\~ | bat --tabs 8
    rm -rf $1\~
  fi
}

edP () {
  if (( $# == 0 )); then
    echo 'Error: No file name given!'; return 1
  else
    if [[ ! -f $1 ]]; then
      echo "#!python3\n\nif __name__ == '__main__':\n    pass" > $1 && chmod +x $1
    fi
    $EDITOR $1
  fi
}

fas () {
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    gcc $@ -std=gnu99 -Wall -Wextra -Og -o out-$(basename $1 .s)
  fi
}

fcc () {
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    gcc $@ -std=gnu99 -Wall -Wextra -O2 -o out-$(basename $1 .c)
  fi
}

fcp () {
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    g++ $@ -std=gnu++14 -Wall -Wextra -O2 -o out-$(basename $1 .cpp)
  fi
}

frs () {
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    rustc $@ -C debuginfo=0 -C opt-level=2 -o out-$(basename $1 .rs)
  fi
}

setopt shwordsplit
for DIR in $TOPATH; do
  if [[ -d $DIR ]]; then
    case :$PATH: in
      *:$DIR:* ) ;;
      * ) export PATH=$PATH:$DIR;;
    esac
  fi
done
