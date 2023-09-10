
# Uncomment on GNU/Linux.
# export PATH='/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin'
# export LD_LIBRARY_PATH='/usr/local/lib:/usr/local/lib64:/usr/local/libexec:/usr/lib:/usr/lib64:/usr/libexec:/lib:/lib64'
TOPATH="$HOME/.local/bin $HOME/.cargo/bin $HOME/.config/emacs/bin"
TOLPATH="$HOME/.local/lib"

export EDITOR='nvim'
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"
export PYTHONDONTWRITEBYTECODE='1'

export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_us=$'\e[01;37m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

SUDO_CMD='sudo'
FOLDER_ICON='  '
EXA_ICONS='--icons'
ZSH_THEME='undollar'
LOCAL_LANG='LANG=en_US.UTF-8'

plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias q='exit'
alias rr='rm -rf'
alias ds='doom sync'
alias t='cd;c;tmux -u'
alias rrs="$SUDO_CMD rm -rf"

alias bat='bat --tabs=8'
alias exa="$LOCAL_LANG exa"
alias e="( emacs > /dev/null 2>&1 )&"
alias cpwd="c;echo -n '${FOLDER_ICON}PWD in ';pwd"

alias la='exa -a'
alias lx="exa $EXA_ICONS -albh --git --classify --group --group-directories-first"
alias ll="exa $EXA_ICONS -albh --git --classify --no-user --group-directories-first"
alias cla='cpwd;la'
alias cll='cpwd;ll'
alias clx='cpwd;lx'
alias cxl='cpwd;lx'
alias clt='cpwd;lt'

alias edM="$EDITOR Makefile"
alias edrc="$EDITOR ~/.zshrc && . ~/.zshrc"

c () {
  clear
  if [[ $TERM == 'screen-256color-bce' ]]; then
    tmux clear-history
  fi
}

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

alias gits='git status'
alias gite='gitr && cd ..'
alias gitp='git reset --hard HEAD'
alias 'gitp^'='git reset --hard HEAD^'
alias gitr='cd $(git rev-parse --show-toplevel)'
alias gita='git add -A && git commit --amend --no-edit'
alias gitl='git log --date=format-local:"%d/%m/%Y %H:%M:%S" --pretty=format:"%h %ad | %an >>> %s%d" --graph'

giti () {
  $SUDO_CMD rm -rf $(git ls-files --others --ignored --exclude-standard --directory)
}

gitc () {
  if (( $# == 0 )); then
    git config --local --list | bat
  else
    git config --local user.name $1
    git config --local user.email $2
  fi
}

gitup () {
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  if (( $# == 0 )); then
    read "ANS?No commit name given, git pull ($BRANCH)? [Y/n] "
    case $ANS in
      [Nn] ) echo 'Exiting...';;
      *    ) git pull; git status;;
    esac
  else
    git add -A
    git commit -m "$1"
    read "ANS?Commit name given, git push ($BRANCH)? [Y/n] "
    case $ANS in
      [Nn] ) echo 'Exiting...';;
      *    ) git push -u origin $BRANCH; git status;;
    esac
  fi
}

pya () {
  setopt shwordsplit
  if (( $# == 0 )); then
    echo 'Error: No YANG file given!'; return 1
  else
    rm -f /tmp/.__pya_temp_out
    for var in "$@"; do
      echo >> /tmp/.__pya_temp_out
      pyang -f tree $var >> /tmp/.__pya_temp_out
      echo >> /tmp/.__pya_temp_out
    done
    bat /tmp/.__pya_temp_out
    rm -f /tmp/.__pya_temp_out
  fi
}

indchk () {
  if (( $# == 0 )); then
    echo 'Error: No source file given!'; return 1
  else
    indent -gnu -nut $1 -o $1\~ &&  # -npcs
    diff -u $1 $1\~ | bat
    rm -rf $1\~
  fi
}

ptchk() {
  if (( $# == 0 )); then
    echo 'Error: No source file given!'; return 1
  else
    checkpatch.pl --no-tree --strict --max-line-length=90 --file --ignore \
      SPDX_LICENSE_TAG,CONCATENATED_STRING,PREFER_KERNEL_TYPES,SPLIT_STRING,PREFER_DEFINED_ATTRIBUTE_MACRO,BLOCK_COMMENT_STYLE $@
      # SPDX_LICENSE_TAG,CONCATENATED_STRING,PREFER_KERNEL_TYPES,SPLIT_STRING,SSCANF_TO_KSTRTO,FSF_MAILING_ADDRESS,OPEN_ENDED_LINE,VOLATILE,CAMELCASE,BLOCK_COMMENT_STYLE,QUOTED_WHITESPACE_BEFORE_NEWLINE,PREFER_DEFINED_ATTRIBUTE_MACRO,IF_0
  fi
}

edP () {
  if (( $# == 0 )); then
    echo 'Error: No file name given!'; return 1
  else
    if [[ ! -f $1 ]]; then
      echo "#!/usr/bin/env python3\n\nif __name__ == '__main__':\n    pass" > $1 && chmod +x $1
    fi
  fi
}

fas () {
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    gcc $@ -std=gnu99 -Wall -Wextra -Werror -Og -o out-$(basename $1 .s)
  fi
}

fcc () {
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    gcc $@ -std=gnu11 -Wall -Wextra -Werror -O2 -o out-$(basename $1 .c)
  fi
}

fcp () {
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    g++ $@ -std=gnu++14 -Wall -Wextra -Werror -O2 -o out-$(basename $1 .cpp)
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
      * ) export PATH=$DIR:$PATH;;
    esac
  fi
done

for DIR in $TOLPATH; do
  if [[ -d $DIR ]]; then
    case :$LD_LIBRARY_PATH: in
      *:$DIR:* ) ;;
      * ) export LD_LIBRARY_PATH=$DIR:$LD_LIBRARY_PATH;;
    esac
  fi
done
