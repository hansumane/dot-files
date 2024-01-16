# base defines
case "$TERM" in
  *screen* ) ;;
  * ) export TERM="xterm-256color" ;;
esac
export EDITOR='nvim'
export SUDO_CMD='sudo'
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"
export PYTHONDONTWRITEBYTECODE='1'

# man colors
export GROFF_NO_SGR='1'
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_us=$'\e[01;37m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

# local defines
FOLDER_ICON='  '
EZA_GIT='--git'
EZA_ICONS='--icons'
ZSH_THEME='undollar'
LOCAL_LANG='LANG=en_US.UTF-8'

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias c='cl'
alias b='bt'
alias q='exit'
alias rr='rm -rf'
alias rrs="$SUDO_CMD rm -rf"
alias cpwd="c;echo -n '${FOLDER_ICON}PWD in ';pwd"

alias v="$EDITOR"
alias crr='cr -r'
alias cr='cargo run'
alias ds='doom sync'
alias t='cd;c;tmux -u'
alias eza="$LOCAL_LANG eza"

alias la='eza -a'
alias lx="eza $EZA_ICONS -albh $EZA_GIT --classify --group --group-directories-first"
alias ll="eza $EZA_ICONS -albh $EZA_GIT --classify --no-user --group-directories-first"
alias lt='eza $EZA_ICONS -albh $EZA_GIT --classify --no-user --group-directories-first -T'
alias cla='cpwd;la'
alias cll='cpwd;ll'
alias clx='cpwd;lx'
alias cxl='cpwd;lx'
alias clt='cpwd;lt'

alias edM="$EDITOR Makefile"
alias edcr="$EDITOR ~/.git-credentials"
alias edrc="$EDITOR ~/.zshrc && . ~/.zshrc"

vg () {
  valgrind --show-error-list=yes --leak-check=full --show-leak-kinds=all $@
}

bt () {
  bat --tabs=8 $@
}

cl () {
  clear
  case $TERM in
    *screen* ) tmux clear-history ;;
  esac
}

ded () {
  emacsclient -e '(kill-emacs)' &> /dev/null
  emacs --daemon
}

alias gitd='git diff'
alias gits='git status'
alias gite='gitr && cd ..'
alias gitb='git branch -a'
alias gitp='git reset --hard HEAD'
alias 'gitp^'='git reset --hard HEAD^'
alias gitr='cd $(git rev-parse --show-toplevel)'
alias gita='git add -A && git commit --amend --reset-author --no-edit'
alias gitl='git log --date=format-local:"%d/%m/%Y %H:%M:%S" --pretty=format:"%h %ad | %an >>> %s%d" --graph'

giti () {
  GIT_IGNORE_DIR_PATH=$(git rev-parse --show-toplevel) || return 1
  GIT_IGNORE_FILE_PATH=$GIT_IGNORE_DIR_PATH/.gitignore
  cd $GIT_IGNORE_DIR_PATH
  $SUDO_CMD rm -rf $(git ls-files --others --ignored --exclude-from=${GIT_IGNORE_FILE_PATH} --directory)
  cd -
}

gitc () {
  if (( $# == 0 )); then
    git config --local --list | bat
  else
    git config --local user.name "$1"
    git config --local user.email "$2"
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
    read "ANS?Commit name given, git push ($BRANCH)? [Y/n] "
    case $ANS in
      [Nn] ) echo 'Exiting...' ;;
      *    )
        if git config --local --list | grep -q 'user.name' &&
           git config --local --list | grep -q 'user.email'; then
          echo "user.name: $(git config --local 'user.name')"
          echo "user.email: $(git config --local 'user.email')"
          read 'ANS?Are these ok? [Y/n] '
          case $ANS in
            [Nn] ) echo 'Exiting...' ;;
            *    )
              git add -A; git commit -m "$1"
              git push -u origin $BRANCH
              git status
              ;;
          esac
        else
          echo 'git user.name or user.email not set, exiting...'
          return 1
        fi
        ;;
    esac
  fi
}

pya () {
  setopt shwordsplit
  if (( $# == 0 )); then
    echo 'Error: No YANG file(s) given!'; return 1
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
  unsetopt shwordsplit
}

indchk () {
  if (( $# == 0 )); then
    echo 'Error: No source file given!'; return 1
  else
    indent -gnu -nut -l79 -lc82 $1 -o $1\~ &&  # -npcs
    diff -u $1 $1\~ | bat
    rm -rf $1\~
  fi
}

rfmt () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file given!'; return 1
  else
    TEMP_FN="$(basename "$1" .rs)~.rs"
    cp "$1" "$TEMP_FN"
    rustfmt "$TEMP_FN"
    diff -u "$1" "$TEMP_FN" | bat --tabs=8
    rm -rf "$TEMP_FN"
  fi
}

ptchk() {
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    checkpatch.pl --no-tree --strict --max-line-length=90 --file --ignore \
      SPDX_LICENSE_TAG,CONCATENATED_STRING,PREFER_KERNEL_TYPES,SPLIT_STRING,PREFER_DEFINED_ATTRIBUTE_MACRO,BLOCK_COMMENT_STYLE,OPEN_ENDED_LINE,IF_0 $@
      # SPDX_LICENSE_TAG,CONCATENATED_STRING,PREFER_KERNEL_TYPES,SPLIT_STRING,SSCANF_TO_KSTRTO,FSF_MAILING_ADDRESS,OPEN_ENDED_LINE,VOLATILE,CAMELCASE,BLOCK_COMMENT_STYLE,QUOTED_WHITESPACE_BEFORE_NEWLINE,PREFER_DEFINED_ATTRIBUTE_MACRO,IF_0
  fi
}

edP () {
  if (( $# == 0 )); then
    echo 'Error: No file name given!'; return 1
  else
    if [[ ! -f $1 ]]; then
      echo "#!/usr/bin/env python3\n" > $1
      echo 'if __name__ == "__main__":' >> $1
      echo '    pass' >> $1
      chmod +x $1
    fi
  fi
}

edC () {
  if [[ ! -f ./compile_flags.txt ]]; then
    echo '-std=c++20' > ./compile_flags.txt
    echo '-Wall' >> ./compile_flags.txt
    echo '-Wextra' >> ./compile_flags.txt
    echo '-Wformat' >> ./compile_flags.txt
    echo '-Wpedantic' >> ./compile_flags.txt
    echo '-Wno-vla' >> ./compile_flags.txt
    echo '-Wno-unused-variable' >> ./compile_flags.txt
    echo '-Wno-unused-parameter' >> ./compile_flags.txt
  fi

  $EDITOR ./compile_flags.txt

  GIT_TOPDIR="$(git rev-parse --show-toplevel)" || return 0
  GIT_INFODIR="$GIT_TOPDIR/.git/info"
  mkdir -p "$GIT_INFODIR" && touch "$GIT_INFODIR/exclude"
  if ! grep -Fxq 'compile_flags.txt' "$GIT_INFODIR/exclude"; then
    echo 'compile_flags.txt' >> "$GIT_INFODIR/exclude"
  fi
}

fcc () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file(s) given!'; return 1
  else
    gcc -g -O2 -std=gnu11 -Wall -Wextra -Wformat -Wpedantic -o out-$(basename $1 .c) $@
  fi
}

fcp () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file(s) given!'; return 1
  else
    g++ -g -O2 -std=c++20 -Wall -Wextra -Wformat -Wpedantic -o out-$(basename $1 .cpp) $@
  fi
}

frs () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file(s) given!'; return 1
  else
    rustc -C opt-level=2 -o out-$(basename $1 .rs) $@
    #     -C debuginfo=0 -C opt-level=3 -C lto='true' -C codegen-units=1 -C strip='symbols' -o out-$(basename $1 .rs) $@
    #     -C debuginfo=0 -C opt-level=3 -C codegen-units=1 -C strip=symbols -C prefer-dynamic
  fi
}

update_path () {
  setopt shwordsplit

    TOBPATH="/bin /usr/sbin /usr/bin"
  TOBPATH+=" /usr/local/sbin /usr/local/bin"
  TOBPATH+=" $HOME/.local/bin $HOME/.cargo/bin $HOME/.config/emacs/bin"

    TOLPATH="/libexec /lib /lib64"
  TOLPATH+=" /usr/libexec /usr/lib /usr/lib64"
  TOLPATH+=" /usr/local/libexec /usr/local/lib /usr/local/lib64"
  TOLPATH+=" $HOME/.local/lib"

  for DIR in $TOBPATH; do
    if [[ -d $DIR ]]; then
      export PATH="$(echo -n ":$PATH:" | sed "s/:$(echo -n "$DIR" | sed 's/\//\\\//g'):/:/g")"
      export PATH="$DIR:$PATH"
    fi
  done
  export PATH="$(echo -n ":$PATH:" | sed 's/:\+/:/g' | sed 's/^:\(.*\):$/\1/g')"

  for DIR in $TOLPATH; do
    if [[ -d $DIR ]]; then
      export LD_LIBRARY_PATH="$(echo -n ":$LD_LIBRARY_PATH:" | sed "s/:$(echo -n "$DIR" | sed 's/\//\\\//g'):/:/g" | sed 's/^:\(.*\):$/\1/g')"
      export LD_LIBRARY_PATH="$DIR:$LD_LIBRARY_PATH"
    fi
  done
  export LD_LIBRARY_PATH="$(echo -n ":$LD_LIBRARY_PATH:" | sed 's/:\+/:/g' | sed 's/^:\(.*\):$/\1/g')"

  unsetopt shwordsplit
}

update_path
