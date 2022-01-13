export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"
# export SUDOCMD="doas"
export SUDOCMD="sudo"

# Theme
ZSH_THEME="simple"

# Plugins
plugins=(git zsh-syntax-highlighting) # zsh-autosuggestions

source $ZSH/oh-my-zsh.sh


# Aliases

alias c="clear"
alias q="exit"

alias ls="exa --icons"
alias la="exa --icons -a"
alias lx="exa --icons -alh --no-user --group-directories-first"
alias cla="c;la"
alias clx="c;lx"
alias clt="c;lt"

alias rrb="rr out_*;rr out-*"
alias sbn="$SUDOCMD reboot"
alias sdn="$SUDOCMD shutdown now"

alias rr="ranger"
alias fetch="c;neofetch"
alias nviM="nvim Makefile"
alias flas="c;startx"
alias movpn="$SUDOCMD openvpn --config $HOME/Others/Files/file.ovpn"

killsbar ()
{
    kill $(ps -aux | grep 'sbar' | grep '/bin/sh' | awk '{print $2}')
}

lt ()
{
  if (( $# == 0 ))
  then
    exa --icons --group-directories-first -aT --level=2
  else
    if [[ $1 == a ]]
    then
      exa --icons --group-directories-first -aT
    else
      exa --icons --group-directories-first -aT --level=$1
    fi
  fi
}

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
