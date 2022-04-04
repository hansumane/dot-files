# p10k things
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]
# then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"

# Sudo command
SUDOCMD="doas"
# alias doas="sudo"

# If exa will show icons or not
EXAICONS="--icons"

# Theme
ZSH_THEME="dollar"

# Plugins
plugins=() # git zsh-syntax-highlighting zsh-autosuggestions

source $ZSH/oh-my-zsh.sh


# Aliases

alias c="clear"
alias q="exit"

alias t="c;tmux"
alias ls="exa $EXAICONS"
alias la="exa $EXAICONS -a"
alias lx="exa $EXAICONS -alh --no-user --group-directories-first"
alias cls="c;ls"
alias cla="c;la"
alias clx="c;lx"
alias clt="c;lt"

alias rr="rm -rf"
alias sbn="$SUDOCMD reboot"
alias sdn="$SUDOCMD poweroff"

alias ra="ranger"
alias fetch="c;pfetch"
alias nviM="nvim Makefile"
alias flas="c;startx"

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

# run 'p10k configure' to configure
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# eval "$(starship init zsh)"
