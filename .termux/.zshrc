export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="apple-custom-android"

# Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh


# Aliases

alias c="clear"
alias q="c;exit"

alias ls="exa --icons"
alias la="exa --icons -a"
alias lx="exa --icons -alh --no-user --group-directories-first"
alias cla="c;la"
alias clx="c;lx"
alias clt="c;lt"

alias rr="rm -rf"
alias rrb="rr out_*;rr out-*"

alias fetch="c;neofetch"
alias py="python3"
alias nv="nvim"
alias nviM="nv Makefile"

alias updg="pkg upgrade -y && apt update && apt full-upgrade -y"
alias upcl="pkg autoclean -y && apt autoremove -y"
alias updc="updg && upcl"

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
    clang -g -Wall -std=c99 $1 -o $res && echo "Done"
  fi
}

cpb ()
{
  if (( $# == 0 ))
  then
    echo "Wrong C++Build args"
  else
    res="out_$(basename $1 .cpp)"
    clang++ -g -Wall $1 -o $res && echo "Done"
  fi
}

cbm ()
{
  if (( $# == 0 ))
  then
    echo "Wrong CBuild args"
  else
    res="out_$(basename $1 .c)"
    clang -g -Wall -std=c99 -lm $1 -o $res && echo "Done"
  fi
}

cpbm ()
{
  if (( $# == 0 ))
  then
    echo "Wrong C++Build args"
  else
    res="out_$(basename $1 .cpp)"
    clang++ -g -Wall -lm $1 -o $res && echo "Done"
  fi
}
