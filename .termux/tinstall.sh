echo "bell-character = ignore" > ~/.termux/termux.properties;
pkg upgrade -y &&
apt update &&
apt full-upgrade -y &&
pkg install root-repo curl wget git zip unzip tar nano vim neovim binutils clang python zsh exa neofetch hexyl -y;
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
cd ~/.oh-my-zsh/custom/plugins &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git &&
git clone https://github.com/zsh-users/zsh-autosuggestions.git;
cp ~/storage/Programming/backup/font.ttf ~/.termux &&
cp ~/storage/Programming/backup/colors.properties ~/.termux &&
cp ~/storage/Programming/backup/apple-custom.zsh-theme ~/.oh-my-zsh/custom/themes;
mkdir ~/.config/nvim -p &&
echo 'filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber' > ~/.config/nvim/init.vim &&
echo 'export TERM="xterm-256color"
export EDITOR="nvim"
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
alias clx="c;lx"
alias rrc="rr out_* out-*"

alias fetch="c;neofetch"
alias py="python3"
alias nv="nvim"
alias nvm="nv Makefile"

alias updg="pkg upgrade -y && apt update && apt full-upgrade -y"
alias upcl="pkg autoclean -y && apt autoremove -y"
alias updc="updg && upcl"

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

cpb ()
{
  if (( $# == 0 ))
  then
    echo "Wrong C++Build args"
  else
    res="out_$(basename $1 .cpp)"
    clang++ $1 -o $res && echo "Done"
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

cpbm ()
{
  if (( $# == 0 ))
  then
    echo "Wrong C++Build args"
  else
    res="out_$(basename $1 .cpp)"
    clang++ -lm $1 -o $res && echo "Done"
  fi
}' > ~/.zshrc;
cd && clear && echo "Done!"