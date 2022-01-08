sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
cd ~/.oh-my-zsh/custom/plugins &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git;
# git clone https://github.com/zsh-users/zsh-autosuggestions.git;
cd; git clone https://github.com/sindresorhus/pure.git &&
cd pure &&
cat pure.zsh > ~/.oh-my-zsh/custom/themes/pure.zsh-theme &&
mkdir ~/.oh-my-zsh/functions &&
cat async.zsh > ~/.oh-my-zsh/functions/async &&
cd && rm -rf pure;
mkdir ~/.config/nvim -p &&
echo 'filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0' > ~/.config/nvim/init.vim &&
echo 'export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="pure"

# Plugins
plugins=(git zsh-syntax-highlighting) # zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh


# Aliases

alias c="clear"
alias rr="rm -rf"
alias q="c;exit"

alias ls="exa --icons"
alias la="exa --icons -a"
alias lx="exa --icons -alh --no-user --group-directories-first"

alias cla="c;la"
alias clx="c;lx"
alias rrc="rr out_*;rr out-*"
alias fetch="c;neofetch"
alias nviM="nvim Makefile"

alias flas="c;startx"

alias movpn="sudo openvpn --config $HOME/Others/Files/file.ovpn"

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
}' >> ~/.zshrc;
cd; mkdir Desktop Downloads Others && cd Others &&
mkdir -p Templates Shared Documents Music Pictures/Screenshots Videos &&
echo 'XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Others/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Others/Shared"
XDG_DOCUMENTS_DIR="$HOME/Others/Documents"
XDG_MUSIC_DIR="$HOME/Others/Music"
XDG_PICTURES_DIR="$HOME/Others/Pictures"
XDG_VIDEOS_DIR="$HOME/Others/Videos"' > ~/.config/user-dirs.dirs &&
echo 'en_US' > ~/.config/user-dirs.locale
