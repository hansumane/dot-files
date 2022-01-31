export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"

# Sudo command
SUDOCMD="sudo"

# If exa will show icons or not
EXAICONS="--icons"

# Theme
ZSH_THEME="simple"

# Plugins
plugins=(git zsh-syntax-highlighting) # zsh-autosuggestions

source $ZSH/oh-my-zsh.sh


# Aliases

alias c="clear"
alias q="exit"

alias ls="exa $EXAICONS"
alias la="exa $EXAICONS -a"
alias lx="exa $EXAICONS -alh --no-user --group-directories-first"
alias cla="c;la"
alias clx="c;lx"
alias clt="c;lt"

alias rr="rm -rf"
alias sbn="$SUDOCMD reboot"
alias sdn="$SUDOCMD shutdown now"

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
