# ----------------------------------
# Rounded minimal zsh theme
# Creator: owl4ce
# ----------------------------------
# https://github.com/owl4ce/dotfiles
# Requires Nerd Fonts for the icons:
# ----------------------------------
#           
# ----------------------------------
num_dirs=2
truncated_path="%F{7}%K{7} %F{0} %K{7} %F{0}%$num_dirs~ %{%k%}%F{7}"
background_jobs="%(1j.%F{0}%K{0} %F{3} %{%k%}%F{0}%f.)"
non_zero_return_value="%(0?..%F{7}%K{7} %F{1}  %{%k%}%F{7}%f)"
# ----------------------------------
ZSH_THEME_GIT_PROMPT_PREFIX="%F{7}%K{7} %F{0} %K{7} "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{%k%}%F{7} %{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%} "
# ----------------------------------
PROMPT='$truncated_path $user_symbol'
RPROMPT=' $background_jobs $non_zero_return_value $(git_prompt_info)'
zle_highlight=(default:bold)
