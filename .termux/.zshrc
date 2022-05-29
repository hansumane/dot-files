export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"
export EXA_COLORS="di=1;35:da=0;35"

EXAICONS="--icons"
SYSFETCH="neofetch"
ZSH_THEME="awesomepanda"
plugins=(git svn zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


alias c="clear"
alias q="exit"

alias t="tmux"
alias ls="exa $EXAICONS"
alias la="exa $EXAICONS -a"
alias ll="exa $EXAICONS -alh --group-directories-first"
alias lx="exa $EXAICONS -alh --no-user --group-directories-first"
alias cls="c;ls"
alias cla="c;la"
alias clx="c;lx"
alias cll="c;ll"
alias clt="c;lt"

alias rr="rm -rf"

alias gits="git status"
alias fetch="c;$SYSFETCH"
alias viM="vim Makefile"
alias nviM="nvim Makefile"
alias grep="grep --color=auto"

lt ()
{
  if (( $# == 0 )); then
    exa $EXAICONS --group-directories-first -aT --level=2
  else
    if [[ $1 == a ]]; then
      exa $EXAICONS --group-directories-first -aT
    else
      exa $EXAICONS --group-directories-first -aT --level=$1
    fi
  fi
}

gitup ()
{
  if (( $# == 0)); then
    if read -q "choice?No commit name given, git pull? "; then
      echo ""; git pull
    else
      echo "\nExiting..."
    fi
  else
    git add -A; git commit -m$1
    if read -q "choice?Commit name given, git push? "; then
      echo ""; git push
    else
      echo "\nExiting..."
    fi
  fi
}

fcc ()
{
  if (( $# == 0)); then
    echo "No source file(s) given!"
  else
    clang -Wall -std=c99 $@ -o out-$(basename $1 .c)
  fi
}

fcp ()
{
  if (( $# == 0)); then
    echo "No source file(s) given!"
  else
    clang++ -Wall $@ -o out-$(basename $1 .cpp)
  fi
}

alias updg="pkg upgrade -y && apt update && apt full-upgrade -y"
alias upcl="pkg autoclean -y && apt autoremove -y && apt autoclean -y"
alias updc="updg && upcl"
