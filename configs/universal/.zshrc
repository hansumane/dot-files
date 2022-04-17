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

alias c="clear"
alias q="exit"

alias ls="exa $EXAICONS"
alias la="exa $EXAICONS -a"
alias lx="exa $EXAICONS -alh --no-user --group-directories-first"
alias cls="c;ls"
alias cla="c;la"
alias clx="c;lx"
alias clt="c;lt"

alias ..="cd .."
alias rr="rm -rf"
alias nviM="nvim Makefile"

lt ()
{
  if (( $# == 0 ))
  then
    exa $EXAICONS --group-directories-first -aT --level=2
  else
    if [[ $1 == a ]]
    then
      exa $EXAICONS --group-directories-first -aT
    else
      exa $EXAICONS --group-directories-first -aT --level=$1
    fi
  fi
}

[[ ! -f $ZSH/.p10k.zsh ]] || source $ZSH/.p10k.zsh
