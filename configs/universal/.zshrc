# for powerlevel10k
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export TERM="xterm-256color"
export EDITOR="vim"
export ZSH="$HOME/.oh-my-zsh"
export EXA_COLORS="di=1;35:da=0;35"

SUDOCMD="sudo"
EXAICONS="--icons"
SYSFETCH="neofetch"
ZSH_THEME="awesomepanda"
plugins=(git svn zsh-syntax-highlighting) # zsh-autosuggestions

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
alias sbn="$SUDOCMD reboot"
alias sdn="$SUDOCMD poweroff"

alias ra="ranger"
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
    cc -Wall -std=c99 $@ -o out-$(basename $1 .c)
  fi
}

fcp ()
{
  if (( $# == 0)); then
    echo "No source file(s) given!"
  else
    c++ -Wall $@ -o out-$(basename $1 .cpp)
  fi
}

# sourcing powerlevel10k config
# [[ ! -f ~/.oh-my-zsh/.p10k.zsh ]] || source ~/.oh-my-zsh/.p10k.zsh
