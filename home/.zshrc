# Shell options
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_REDUCE_BLANKS
setopt CORRECT
setopt CORRECT_ALL

# Non-zsh-specific
source ~/.profile

# Word deletion
autoload -U select-word-style
select-word-style bash

# History search
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_FUZZY=1

# Prompt
source "${HOME}/.zsh_prompt"
autoload -U promptinit; promptinit
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f %F{yellow}%c%u%m%f'
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:*:*' stagedstr '+'
# zstyle ':vcs_info:*:*' unstagedstr '!'
# zstyle ':vcs_info:*:*' check-for-changes true
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-stash
# +vi-git-untracked() {
#   if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#     git status --porcelain | grep -m 1 '^??' &>/dev/null
#   then
#     hook_com[misc]="${hook_com[misc]}?"
#   fi
# }
# +vi-git-stash() {
#   local -a stashes
#   stashes=$(git stash list 2>/dev/null | wc -l)
#   if [[ $stashes -gt 0 ]]; then
#     hook_com[misc]="${hook_com[misc]}$"
#   fi
# }

# colors
export CLICOLOR=1
export TERM="xterm-color"

# completions support
autoload -Uz compinit && compinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# Add cliptube to $PATH
export PATH="$HOME/.cliptube/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
