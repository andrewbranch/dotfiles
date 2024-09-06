# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_FUZZY=1

# Prompt
# source "${HOME}/.zsh_prompt"
# autoload -U promptinit; promptinit
# zstyle ':completion:*' completer _complete _ignored _approximate
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
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


# bun completions
[ -s "/Users/andrew/.bun/_bun" ] && source "/Users/andrew/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Add node_modules/.bin to PATH
function precmd() {
  path=( ${path[@]:#*node_modules*} )
  local p="$(pwd)"
  while [[ "$p" != '/' ]]; do
    if [[ -d "$p/node_modules/.bin" ]]; then
      path+=("$p/node_modules/.bin")
    fi
    p="$(dirname "$p")"
  done
  typeset -U path
}

# pnpm
export PNPM_HOME="/Users/andrew/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
