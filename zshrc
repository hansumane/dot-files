export TERM="xterm-256color"

export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="pure"

# Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh


# Aliases

alias c="clear"
alias rr="rm -rf"
alias q="c;exit"

alias ls="exa --icons"
alias la="exa --icons -a"
alias lx="exa --icons -alh --no-user --group-directories-first"

alias cla="c;la"
alias rrc="rm -rf out_*"

alias vim="nvim"
alias py="python3"
alias miet="sudo openvpn --config $HOME/Others/Files/miet.ovpn"

lt ()
{
  if (( $# == 0 ))
  then
    exa --icons -aT --level=2
  else
    if [[ $1 == a ]]
    then
      exa --icons -aT
    else
      exa --icons -aT --level=$1
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
    clang -std=c99 $1 -o $res && echo "Done"
  fi
}

cbm ()
{
  if (( $# == 0 ))
  then
    echo "Wrong CBuild args"
  else
    res="out_$(basename $1 .c)"
    clang -std=c99 -lm $1 -o $res && echo "Done"
  fi
}

cd;c;la
