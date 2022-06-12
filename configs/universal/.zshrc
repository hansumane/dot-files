# for powerlevel10k
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"
export EXA_COLORS="di=1;35:da=0;35"

SUDO_CMD="sudo"
EXA_ICONS="--icons"
SYS_FETCH="neofetch"
ZSH_THEME="awesomepanda"
LOCAL_LANG="LANG=en_US.UTF-8"
plugins=(git svn zsh-syntax-highlighting) # zsh-autosuggestions

source $ZSH/oh-my-zsh.sh


alias c="clear"
alias q="exit"

alias t="tmux"
alias ls="$LOCAL_LANG exa $EXA_ICONS"
alias la="$LOCAL_LANG exa $EXA_ICONS -a"
alias lk="$LOCAL_LANG exa $EXA_ICONS -alh --group-directories-first"
alias lx="$LOCAL_LANG exa $EXA_ICONS -alh --no-user --group-directories-first"
alias cls="c;ls"
alias cla="c;la"
alias clx="c;lx"
alias clk="c;lk"
alias clt="c;lt"

alias rr="rm -rf"
alias sbn="$SUDO_CMD reboot"
alias sdn="$SUDO_CMD poweroff"

alias gits="git status"
alias fetch="c;$SYS_FETCH"
alias viM="vim Makefile"
alias nviM="nvim Makefile"
alias grep="grep --color=auto"

lt ()
{
  if (( $# == 0 )); then
    env $LOCAL_LANG exa $EXA_ICONS --group-directories-first -aT --level=2
  else
    if [[ $1 == a ]]; then
      env $LOCAL_LANG exa $EXA_ICONS --group-directories-first -aT
    else
      env $LOCAL_LANG exa $EXA_ICONS --group-directories-first -aT --level=$1
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

fcc ()
{
  if (( $# == 0)); then
    echo "No source file(s) given!"
  else
    gcc -g -Wall -O -std=c99 $@ -o out-$(basename $1 .c)
  fi
}

fcp ()
{
  if (( $# == 0)); then
    echo "No source file(s) given!"
  else
    g++ -g -Wall -O $@ -o out-$(basename $1 .cpp)
  fi
}

# sourcing powerlevel10k config
# [[ ! -f ~/.oh-my-zsh/.p10k.zsh ]] || source ~/.oh-my-zsh/.p10k.zsh
