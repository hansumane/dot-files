export ZSH="$HOME/.zsh-things"
source "$ZSH/powerlevel10k/powerlevel10k.zsh-theme"
source "$ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"
export EDITOR="nvim"

SUDOCMD="sudo"
EXAICONS="--icons"
SYSFETCH="neofetch"

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

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ra="ranger"
alias rr="rm -rf"
alias fetch="c;$SYSFETCH"
alias nviM="nvim Makefile"
alias grep="grep --color=auto"

alias gitget="git clone --depth=1"

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
      echo "Exiting..."
    fi
  else
    git add -A; git commit -m$1
    if read -q "choice?Commit name given, git push? "; then
      echo ""; git push
    else
      echo "Exiting..."
    fi
  fi
}

[[ ! -f $ZSH/.p10k.zsh ]] || source $ZSH/.p10k.zsh
