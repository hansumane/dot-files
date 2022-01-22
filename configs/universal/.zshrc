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
alias rrb="rm -f out_*;rm -f out-*"
alias sbn="$SUDOCMD reboot"
alias sdn="$SUDOCMD shutdown now"

alias ra="ranger"
alias fetch="c;neofetch"
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

# Unnecessary if you use Makefiles
cb ()
{
  if (( $# == 0 ))
  then
    echo "Wrong CBuild args"
  else
    res="out_$(basename $1 .c)"
    gcc -g -Wall -std=c99 $1 -o $res && echo "Done"
  fi
}

cpb ()
{
  if (( $# == 0 ))
  then
    echo "Wrong C++Build args"
  else
    res="out_$(basename $1 .cpp)"
    g++ -g -Wall $1 -o $res && echo "Done"
  fi
}

cbm ()
{
  if (( $# == 0 ))
  then
    echo "Wrong CBuild args"
  else
    res="out_$(basename $1 .c)"
    gcc -g -Wall -std=c99 -lm $1 -o $res && echo "Done"
  fi
}

cpbm ()
{
  if (( $# == 0 ))
  then
    echo "Wrong C++Build args"
  else
    res="out_$(basename $1 .cpp)"
    g++ -g -Wall -lm $1 -o $res && echo "Done"
  fi
}
