export PS1='\u@\h:\w\$ '
export TERM='xterm-256color'
export EDITOR='nvim'
export PATH="$PATH:$HOME/.local/bin"

alias c='clear'
alias q='exit'
alias t='c;tmux'
alias rr='rm -rf'

alias ls='LANG=en_US.UTF-8 ls'
alias exa='LANG=en_US.UTF-8 exa'
alias cpwd="c;echo -n 'PWD in ';pwd"

alias la='ls -A'
alias ll='ls -alh --classify --group-directories-first'
alias lx='ls -Alh --classify --group-directories-first'
alias lexa='cpwd;exa -albh --git --classify --no-user --group-directories-first'
alias cla='cpwd;la'
alias cll='cpwd;ll'
alias clx='cpwd;lx'

alias gits='git status'
alias gitr='cd $(git rev-parse --show-toplevel)'
alias gitl='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

gitup () {
  if [[ $# -eq 0 ]]; then
    read -p 'No commit name given, git pull? [Y/n] ' ANS
    case $ANS in
      [Nn] ) echo 'Exiting...';;
      *    ) git pull --rebase; git status;;
    esac
  else
    git add -A
    git commit -m "$1"
    read -p 'Commit name given, git push? [Y/n] ' ANS
    case $ANS in
      [Nn] ) echo 'Exiting...';;
      *    ) git push; git status;;
    esac
  fi
}

fcc () {
  if [[ $# -eq 0 ]]; then
    echo 'error: no source file(s) given!'
    return 1
  else
    gcc $@ -std=gnu99 -Wall -Os -o out-$(basename $1 .c)
  fi
}

fcp () {
  if [[ $# -eq 0 ]]; then
    echo 'error: no source file(s) given!'
    return 1
  else
    clang++ $@ -Wall -Os -o out-$(basename $1 .cpp)
  fi
}
