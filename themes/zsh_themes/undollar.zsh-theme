# undollar.zsh-theme
NL=$'\n'
PROMPT='╭ %B%6~%b${NL}╰─$(git_prompt_info)%B->%b '
ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}X%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"
