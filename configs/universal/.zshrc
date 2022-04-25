# for powerlevel10k
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"

SUDOCMD="sudo"
EXAICONS="--icons"
SYSFETCH="neofetch"
ZSH_THEME="robbyrussell"
plugins=(zsh-syntax-highlighting) #git zsh-autosuggestions

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

# sourcing powerlevel10k config
# [[ ! -f ~/.oh-my-zsh/.p10k.zsh ]] || source ~/.oh-my-zsh/.p10k.zsh
