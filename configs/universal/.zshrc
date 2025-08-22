# base defines
case "$TERM" in
  *screen* ) ;;
  * ) export TERM="xterm-256color" ;;
esac
export CC='gcc'
export CXX='g++'
export AWK_CMD='awk'
export SED_CMD='sed'
export EDITOR='nvim'
export PYTHONDONTWRITEBYTECODE='1'

export HISTSIZE=131072
export SAVEHIST=1048576
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

# man colors
export GROFF_NO_SGR='1'
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;33m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_us=$'\e[01;37m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

# fzf colors (rose-pine main)
export FZF_DEFAULT_OPTS=" \
--color=fg:#908CAA,bg:#191724,hl:#EBBCBA \
--color=fg+:#E0DEF4,bg+:#26233A,hl+:#EBBCBA \
--color=border:#403D52,header:#31748F,gutter:#191724 \
--color=spinner:#F6C177,info:#9CCFD8 \
--color=pointer:#C4A7E7,marker:#EB6F92,prompt:#908CAA"

# sudo
export SUDO_CMD='sudo'
alias $SUDO_CMD="$SUDO_CMD env PATH=\$PATH"

# local defines
FOLDER_ICON='  '
EZA_GIT='--git'
EZA_ICONS='--icons'
ZSH_THEME='powerlevel10k/powerlevel10k'
LOCAL_LANG='LANG=en_US.UTF-8'

# removed plugins: (git zsh-vi-mode)
plugins=(zsh-syntax-highlighting zsh-autosuggestions)
source "$ZSH/oh-my-zsh.sh"

alias grep='grep --color=auto'
alias ip="$SUDO_CMD ip --color=auto"
alias bridge="$SUDO_CMD bridge --color=auto"

alias c='cl'
alias b='bt'
alias t='tm'
alias q='exit 0'
alias rr='rm -rf'
alias rrs="$SUDO_CMD rm -rf"
alias cpwd="c;echo -n '${FOLDER_ICON}PWD in ';pwd"

alias v="$EDITOR"
alias vd="$EDITOR ."
alias z='zathura'
alias lg='lazygit'
alias cr='cargo run'
alias crr='cargo run -rq'
alias tl='clear; tmux list-sessions'
alias ds="doom sync --jobs $(getconf _NPROCESSORS_ONLN)"
alias dsu="ds -u"
alias dsnou="ds -U"
alias eza="$LOCAL_LANG eza"

alias la='eza -a'
alias lx="eza $EZA_ICONS -albh --classify --group --group-directories-first"
alias ll="eza $EZA_ICONS -albh --classify --no-user --group-directories-first"
alias lt="eza $EZA_ICONS -albh --classify --no-user --group-directories-first -T"
alias cla='cpwd;la'
alias cll='cpwd;ll'
alias clx='cpwd;lx'
alias cxl='cpwd;lx'
alias glx='cpwd;lx --git'
alias gxl='cpwd;lx --git'
alias clt='cpwd;lt'
alias glt='cpwd;lt --git'

alias edM="$EDITOR Makefile"
alias edcr="$EDITOR ~/.git-credentials"
alias edrc="$EDITOR ~/.zshrc && . ~/.zshrc"

gr () {
  $@ &> /dev/null &
  disown
}

vg () {
  valgrind --show-error-list=yes \
           --leak-check=full --show-leak-kinds=all \
           --track-origins=yes $@
}

bt () {
  bat --tabs=8 $@
}

br () {
  find . '(' -type f -iname $@ ')' -exec bat --tabs=8 {} '+'
}

_hxl () {
  setopt shwordsplit
  if (( $# == 0 )); then
    echo 'Error: No file(s) given!'; return 1
  else
    for FN in $@; do
      echo "$FN"
      hexyl "$FN"
    done
  fi
  unsetopt shwordsplit
}

hxl () {
  _hxl $@ | bat --tabs=8
}

cl () {
  if command -v clear &> /dev/null; then
    clear
  else
    printf "\033[H\033[J"
  fi

  case "$TERM" in
    *screen* ) tmux clear-history ;;
  esac
}

tm () {
  cd

  if (( $# == 0 )); then
    tmux -u new-session -A -s ' '
  else
    tmux -u new-session -A -s $@
  fi

  cd -
}

ded () {
  cd
  emacsclient -e '(kill-emacs)' > /dev/null 2>&1
  (( $# == 0 )) && doom run --daemon
  cd -
}

alias gitd='git diff'
alias gitdc='git diff --cached'
alias gitc='git commit'
alias gits='git status'
alias gitb='git branch -a'
alias gitup='git fetch --all --prune && git status'
alias gitr='cd $(git rev-parse --show-toplevel)'
alias gitrb='git rebase -i --root $(git rev-parse --abbrev-ref HEAD)'
alias gita='git add -A && git commit --amend --reset-author --no-edit'
alias gitl='git log --graph --pretty=format:"%C(red)%h%C(reset) | %s %C(green)(%cr)%C(reset) %C(blue)%an%C(reset) %C(bold magenta)<%ae>%C(reset)%C(yellow)%d%C(reset)"'
alias gitll='git log --graph --date=format-local:"%Y/%m/%d %H:%M" --pretty=format:"%C(red)%h%C(reset) | %s %C(green)(%cd)%C(reset) %C(blue)%an%C(reset) %C(bold magenta)<%ae>%C(reset)%C(yellow)%d%C(reset)"'
alias gitlll='git log --pretty=fuller'

# git diff --cache    # shows differences between HEAD and currently staged changes
# git add -p [file]   # interactively adds hunks from optional file
# git reset -p [file] # interactively unstage hunks from optional file

giti () {
  if ! git rev-parse --show-toplevel &> /dev/null ; then
    echo "'$PWD' is not inside any git repository"
    return 1
  fi

  local GIT_IGNORE_DIR_PATH="$(git rev-parse --show-toplevel)"
  local GIT_IGNORE_FILE_PATH="$GIT_IGNORE_DIR_PATH/.gitignore"
  cd "$GIT_IGNORE_DIR_PATH"
  $SUDO_CMD rm -rf $(git ls-files --others --ignored --exclude-from="$GIT_IGNORE_FILE_PATH" --directory)
  cd -
}

gitcfg () {
  if (( $# == 0 )); then
    git config --local --list
  else
    git config --local user.name "$1"
    git config --local user.email "$2"
  fi
}

pya () {
  setopt shwordsplit
  if (( $# == 0 )); then
    echo 'Error: No YANG file(s) given!'; return 1
  else
    rm -f /tmp/.__pya_temp_out
    for var in $@; do
      echo >> /tmp/.__pya_temp_out
      pyang -f tree "$var" >> /tmp/.__pya_temp_out
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
    diff -u "$1" "$1~" | bat --tabs=8
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

export PTCHK_IGNORES="SPDX_LICENSE_TAG,FILE_PATH_CHANGES,COMMIT_MESSAGE"
export PTCHK_MAX_LL=80
ptchk() {
  echo "checkpatch.pl PTCHK_MAX_LL=$PTCHK_MAX_LL; PTCHK_IGNORES='$PTCHK_IGNORES'"
  if (( $# == 0 )); then
    echo 'Error: No source file(s) given!'; return 1
  else
    checkpatch.pl --no-tree --no-signoff --show-types --strict --file \
                  --max-line-length="$PTCHK_MAX_LL" \
                  --ignore "$PTCHK_IGNORES" $@
  fi
}

edP () {
  if (( $# == 0 )); then
    echo 'Error: No file name given!'; return 1
  else
    if [[ ! -f "$1" ]]; then
      echo "#!/usr/bin/env python3\n" > "$1"
      echo 'if __name__ == "__main__":' >> "$1"
      echo '    pass' >> "$1"
      chmod +x "$1"
    fi
  fi
}

alias edCi='edC i'

edC () {
  if [[ ! -f ./compile_flags.txt ]]; then
    echo '-std=gnu17' >> ./compile_flags.txt
    echo '-nostdinc' >> ./compile_flags.txt
    echo '-nostdinc++' >> ./compile_flags.txt
    echo >> ./compile_flags.txt
    echo '-Wall' >> ./compile_flags.txt
    echo '-Wextra' >> ./compile_flags.txt
    echo '-Wformat' >> ./compile_flags.txt
    echo '-Wpedantic' >> ./compile_flags.txt
    echo '-Winline' >> ./compile_flags.txt
    echo '-Werror=inline' >> ./compile_flags.txt
    echo >> ./compile_flags.txt
    echo '-Wno-c23-extensions' >> ./compile_flags.txt
    echo '# allow empty initializers' >> ./compile_flags.txt
    echo >> ./compile_flags.txt
    echo '-Wno-varargs' >> ./compile_flags.txt
    echo '-Wno-variadic-macros' >> ./compile_flags.txt
    echo '-Wno-gnu-zero-variadic-macro-arguments' >> ./compile_flags.txt
    echo '# define func(args...) ##args' >> ./compile_flags.txt
    echo >> ./compile_flags.txt
    echo '-Wno-language-extension-token' >> ./compile_flags.txt
    echo '-Wno-gnu-statement-expression-from-macro-expansion' >> ./compile_flags.txt
    echo '# list_* functions' >> ./compile_flags.txt
    echo >> ./compile_flags.txt
    echo '-Wno-gnu-empty-struct' >> ./compile_flags.txt
    echo '-Wno-gnu-pointer-arith' >> ./compile_flags.txt
    echo '-Wno-gnu-binary-literal' >> ./compile_flags.txt
    echo '-Wno-gnu-flexible-array-initializer' >> ./compile_flags.txt
    echo '-Wno-gnu-conditional-omitted-operand' >> ./compile_flags.txt
    echo '# self-explanatory' >> ./compile_flags.txt
    echo >> ./compile_flags.txt
    if ! find /usr/lib*/gcc -type d -name include -exec \
              echo -I{} >> ./compile_flags.txt ';' ; then
      # fallback for termux
      find "$PREFIX"/usr/lib*/clang -type d -name include -exec \
           echo -I{} >> ./compile_flags.txt ';'
    fi
    echo '-I/usr/local/include' >> ./compile_flags.txt
    echo '-I/usr/include' >> ./compile_flags.txt
  fi

  "$EDITOR" ./compile_flags.txt
  (( $# == 0 )) && return 0
  ! git rev-parse --show-toplevel &> /dev/null && return 0

  local TRUE_PATH="$(readlink -f "$PWD")"
  local GIT_TOPDIR="$(git rev-parse --show-toplevel)"
  local GIT_INFODIR="$GIT_TOPDIR/.git/info"
  local GIT_WDDIFF="${TRUE_PATH#"$GIT_TOPDIR"}"

  mkdir -p "$GIT_INFODIR" && touch "$GIT_INFODIR/exclude"
  if ! grep -Fxq "$GIT_WDDIFF/compile_flags.txt" "$GIT_INFODIR/exclude"; then
    echo "$GIT_WDDIFF/compile_flags.txt" >> "$GIT_INFODIR/exclude"
  fi
}

CSB_DO_CSCOPE=0  # true
CSB_DO_CTAGS=1  # false
csb () {
  command -v cscope &> /dev/null ; local have_cscope=$?
  command -v ctags &> /dev/null ; local have_ctags=$?

  if (( $have_cscope != 0 )) && (( $have_ctags != 0 )) ; then
    echo "ERROR: 'cscope' and 'ctags' are not available"
    return 1
  fi

  find . -type f -iname '*.c'   -exec realpath --relative-to="$PWD" {} '+' | uniq >  cscope.files
  find . -type f -iname '*.cpp' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
  find . -type f -iname '*.cxx' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
  find . -type f -iname '*.s'   -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
  find . -type f -iname '*.asm' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
  find . -type f -iname '*.h'   -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
  find . -type f -iname '*.hpp' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files
  find . -type f -iname '*.hxx' -exec realpath --relative-to="$PWD" {} '+' | uniq >> cscope.files

  if (( $have_cscope == 0 )) && (( $CSB_DO_CSCOPE == 0 )) ; then
    find . -type f -name 'cscope.out*' -delete
    cscope -b -q $@ -f cscope.out  # csb -k to build in kernel mode
  fi

  if (( $have_ctags == 0 )) && (( $CSB_DO_CTAGS == 0 )) ; then
    find . -type f -name 'tags' -delete
    ctags -a -L cscope.files -h '.h.H.hpp.hxx.h++'
  fi
}

fcc () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file(s) given!'; return 1
  else
    $CC -O2 -pipe -std='gnu17' \
        -Wall -Wextra -Wformat -Wpedantic -Winline -Werror=inline \
        -Wno-variadic-macros \
        -o out-$(basename $1 .c) $@
  fi
}

fcp () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file(s) given!'; return 1
  else
    $CXX -O2 -pipe -std='c++20' \
         -Wall -Wextra -Wformat -Wpedantic -Winline -Werror=inline \
         -o out-$(basename "$1" .cpp) $@
  fi
}

frs () {
  if (( $# == 0 )); then
    echo 'ERROR: No source file(s) given!'; return 1
  else
    rustc -C debuginfo=0 -C opt-level=3 \
          -C codegen-units=1 \
          -C lto=fat -C strip=symbols \
          -o out-$(basename $1 .rs) $@
  fi
}

alias mvnresolve='mvn clean install dependency:resolve'
alias mvnbuild='mvn clean package'
alias mvndo='mvnbuild && mvnrun'

mvnew () {
  if (( $# == 0 )); then
    echo 'ERROR: No groupId and artifactId was set! (example: mvnew com.example.com:my-app)'; return 1
  fi

  local GROUP_ID=$(echo "$1" | cut -d':' -f1)
  local ARTIFACT_ID=$(echo "$1" | cut -d':' -f2)

  mvn archetype:generate -DgroupId="$GROUP_ID" -DartifactId="$ARTIFACT_ID" -DarchetypeArtifactId=maven-archetype-quickstart
  $SED_CMD -i '/<url>.*<\/url>/a \  <properties>\n    <maven\.compiler\.source>21<\/maven\.compiler\.source>\n    <maven\.compiler\.target>21<\/maven\.compiler\.target>\n    <project\.build\.sourceEncoding>UTF\-8<\/project\.build\.sourceEncoding>\n  <\/properties>' "$ARTIFACT_ID/pom.xml"
}

mvnrun () {
  if (( $# == 0 )); then
    echo 'ERROR: No main class specified'; return 1
  fi

  local JAVA_INDEX="$(echo "$1" | $AWK_CMD -F 'java/' '{print length($1) + 6}')"
  local CLASS_PATH="$(echo "$1" | cut -c "$JAVA_INDEX-" | tr '/' '.')"
  local RESULT="$(basename "$CLASS_PATH" .java)"

  echo "classpath: $RESULT"
  mvn exec:java -Dexec.mainClass="$RESULT"
}

update_path () {
  setopt shwordsplit

  local TOBPATH="/bin /usr/sbin /usr/bin"
       TOBPATH+=" /usr/local/sbin /usr/local/bin"
       TOBPATH+=" $HOME/.local/bin $HOME/.cargo/bin $HOME/.config/emacs/bin"

  for DIR in $TOBPATH; do
    if [[ -d $DIR ]]; then
      export PATH="$(echo -n ":$PATH:" | $SED_CMD "s/:$(echo -n "$DIR" | $SED_CMD 's/\//\\\//g'):/:/g")"
      export PATH="$DIR:$PATH"
    fi
  done
  export PATH="$(echo -n ":$PATH:" | $SED_CMD 's/:\+/:/g' | $SED_CMD 's/^:\(.*\):$/\1/g')"

  local TOLPATH="/libexec /lib /lib64"
       TOLPATH+=" /usr/libexec /usr/lib /usr/lib64"
       TOLPATH+=" /usr/local/libexec /usr/local/lib /usr/local/lib64"
#      TOLPATH+=" /usr/lib/jvm/java-21-openjdk/lib"
#      TOLPATH+=" /usr/lib64/jvm/java-21-openjdk/lib"
       TOLPATH+=" $HOME/.local/lib"
     if command -v rustc &> /dev/null; then
       TOLPATH+=" $(rustc --print sysroot)/lib/rustlib/x86_64-unknown-linux-gnu/lib"
     fi

  for DIR in $TOLPATH; do
    if [[ -d $DIR ]]; then
      export LD_LIBRARY_PATH="$(echo -n ":$LD_LIBRARY_PATH:" | $SED_CMD "s/:$(echo -n "$DIR" | $SED_CMD 's/\//\\\//g'):/:/g" | $SED_CMD 's/^:\(.*\):$/\1/g')"
      export LD_LIBRARY_PATH="$DIR:$LD_LIBRARY_PATH"
    fi
  done
  export LD_LIBRARY_PATH="$(echo -n ":$LD_LIBRARY_PATH:" | $SED_CMD 's/:\+/:/g' | $SED_CMD 's/^:\(.*\):$/\1/g')"

  unsetopt shwordsplit
}

if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

update_path
