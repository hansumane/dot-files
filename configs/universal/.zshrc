# base defines
case "$TERM" in
  *screen* ) ;;
  * ) export TERM="xterm-256color" ;;
esac
export AWK_CMD='awk'
export SED_CMD='sed'
export EDITOR="$(which nvim)"
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

# sudo
export SUDO_CMD='sudo'
alias $SUDO_CMD="$SUDO_CMD "

# local defines
FOLDER_ICON='  '
EZA_GIT='--git'
EZA_ICONS='--icons'
ZSH_THEME='powerlevel10k/powerlevel10k'
LOCAL_LANG='LANG=en_US.UTF-8'

plugins=(zsh-syntax-highlighting zsh-autosuggestions)  # git
source $ZSH/oh-my-zsh.sh

alias c='cl'
alias b='bt'
alias t='tm'
alias q='exit'
alias rr='rm -rf'
alias ip='ip -c=always'
alias bridge='bridge -c=always'
alias rrs="$SUDO_CMD rm -rf"
alias cpwd="c;echo -n '${FOLDER_ICON}PWD in ';pwd"

alias v="$EDITOR"
alias vd="$EDITOR ."
alias crr='cr -r'
alias cr='cargo run'
alias ds='doom sync'
alias tl='clear; tmux list-sessions'
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

tm () {
  cd; clear
  if (( $# == 0 )); then
    tmux -u new-session -A -s "main"
  else
    tmux -u new-session -A -s $@
  fi
}

ded () {
  emacsclient -e '(kill-emacs)' &> /dev/null
  if (( $# == 0 )); then
    emacs --daemon
  fi
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
  local GIT_IGNORE_DIR_PATH=$(git rev-parse --show-toplevel) || return 1
  local GIT_IGNORE_FILE_PATH=$GIT_IGNORE_DIR_PATH/.gitignore
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
  local BRANCH=$(git rev-parse --abbrev-ref HEAD)
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
    if [[ ! -f "$1" ]]; then
      echo "Error: No such file: $1"; return 1
    fi
    indent -gnu -nut -l79 -lc82 "$1" -o "$1~" &&  # -npcs
    diff -u "$1" "$1~" | bat
    rm -rf "$1~"
  fi
}

rfmt () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file given!'; return 1
  else
    if [[ ! -f "$1" ]]; then
      echo "Error: No such file: $1"; return 1
    fi
    local TEMP_FN="$(basename "$1" .rs)~.rs"
    cp "$1" "$TEMP_FN"
    rustfmt "$TEMP_FN"
    diff -u "$1" "$TEMP_FN" | bat --tabs=8
    rm -rf "$TEMP_FN"
  fi
}

ptchk() {
  local PTCHK_IGNORES="SPDX_LICENSE_TAG,SPLIT_STRING,LOGGING_CONTINUATION"
       PTCHK_IGNORES+=",BLOCK_COMMENT_STYLE"
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    checkpatch.pl --no-tree --strict --max-line-length=90 --file --ignore $PTCHK_IGNORES $@
      # SPDX_LICENSE_TAG,CONCATENATED_STRING,PREFER_KERNEL_TYPES,SPLIT_STRING,PREFER_DEFINED_ATTRIBUTE_MACRO,BLOCK_COMMENT_STYLE,OPEN_ENDED_LINE,IF_0 $@
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
    echo '-std=gnu17' > ./compile_flags.txt
    echo '-Wall' >> ./compile_flags.txt
    echo '-Wextra' >> ./compile_flags.txt
    echo '-Wformat' >> ./compile_flags.txt
    echo '-Wpedantic' >> ./compile_flags.txt
    echo '-Wno-variadic-macros' >> ./compile_flags.txt
    echo '-Wno-gnu-empty-struct' >> ./compile_flags.txt
    echo '-Wno-gnu-binary-literal' >> ./compile_flags.txt
    echo '-Wno-gnu-conditional-omitted-operand' >> ./compile_flags.txt
    echo '-Wno-gnu-zero-variadic-macro-arguments' >> ./compile_flags.txt
    echo '#-Wno-vla' >> ./compile_flags.txt
    echo '#-Wno-unused-variable' >> ./compile_flags.txt
    echo '#-Wno-unused-parameter' >> ./compile_flags.txt
  fi

  $EDITOR ./compile_flags.txt

  local GIT_TOPDIR="$(git rev-parse --show-toplevel)" || return 0
  local GIT_INFODIR="$GIT_TOPDIR/.git/info"
  mkdir -p "$GIT_INFODIR" && touch "$GIT_INFODIR/exclude"
  if ! grep -Fxq 'compile_flags.txt' "$GIT_INFODIR/exclude"; then
    echo 'compile_flags.txt' >> "$GIT_INFODIR/exclude"
  fi
}

fcc () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file(s) given!'; return 1
  else
    gcc -g -O2 -std=gnu17 -Wall -Wextra -Wformat -Wpedantic -o out-$(basename $1 .c) $@
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

alias mvnresolve='mvn clean install dependency:resolve'
alias mvnbuild='mvn clean package'
alias mvndo='mvnbuild && mvnrun'

mvnew () {
  if (( $# == 0 )); then
    echo 'ERROR: No groupId and artifactId was set! (example: mvnew com.example.com:my-app)'
  fi

  local GROUP_ID=$(echo "$1" | cut -d':' -f1)
  local ARTIFACT_ID=$(echo "$1" | cut -d':' -f2)

  mvn archetype:generate -DgroupId="$GROUP_ID" -DartifactId="$ARTIFACT_ID" -DarchetypeArtifactId=maven-archetype-quickstart
  $SED_CMD -i '/<url>.*<\/url>/a \  <properties>\n    <maven\.compiler\.source>21<\/maven\.compiler\.source>\n    <maven\.compiler\.target>21<\/maven\.compiler\.target>\n    <project\.build\.sourceEncoding>UTF\-8<\/project\.build\.sourceEncoding>\n  <\/properties>' "$ARTIFACT_ID/pom.xml"
}

mvnrun () {
  if (( $# == 0 )); then
    echo 'ERROR: No main class specified'
  fi

  local JAVA_INDEX=$(echo "$1" | $AWK_CMD -F 'java/' '{print length($1) + 6}')
  local CLASS_PATH=$(echo "$1" | cut -c $JAVA_INDEX- | tr '/' '.')
  local RESULT=$(basename "$CLASS_PATH" .java)

  echo "classpath: $RESULT"
  mvn exec:java -Dexec.mainClass="$RESULT"
}

update_path () {
  setopt shwordsplit

  local TOBPATH="/bin /usr/sbin /usr/bin"
       TOBPATH+=" /usr/local/sbin /usr/local/bin"
       TOBPATH+=" $HOME/.local/bin $HOME/.cargo/bin $HOME/.config/emacs/bin"

  local TOLPATH="/libexec /lib /lib64"
       TOLPATH+=" /usr/libexec /usr/lib /usr/lib64"
       TOLPATH+=" /usr/local/libexec /usr/local/lib /usr/local/lib64"
#      TOLPATH+=" /usr/lib/jvm/java-21-openjdk/lib"
#      TOLPATH+=" /usr/lib64/jvm/java-21-openjdk/lib"
       TOLPATH+=" $HOME/.local/lib"

  for DIR in $TOBPATH; do
    if [[ -d $DIR ]]; then
      export PATH="$(echo -n ":$PATH:" | $SED_CMD "s/:$(echo -n "$DIR" | $SED_CMD 's/\//\\\//g'):/:/g")"
      export PATH="$DIR:$PATH"
    fi
  done
  export PATH="$(echo -n ":$PATH:" | $SED_CMD 's/:\+/:/g' | $SED_CMD 's/^:\(.*\):$/\1/g')"

  for DIR in $TOLPATH; do
    if [[ -d $DIR ]]; then
      export LD_LIBRARY_PATH="$(echo -n ":$LD_LIBRARY_PATH:" | $SED_CMD "s/:$(echo -n "$DIR" | $SED_CMD 's/\//\\\//g'):/:/g" | $SED_CMD 's/^:\(.*\):$/\1/g')"
      export LD_LIBRARY_PATH="$DIR:$LD_LIBRARY_PATH"
    fi
  done
  export LD_LIBRARY_PATH="$(echo -n ":$LD_LIBRARY_PATH:" | $SED_CMD 's/:\+/:/g' | $SED_CMD 's/^:\(.*\):$/\1/g')"

  unsetopt shwordsplit
}

update_path
