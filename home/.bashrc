# bash completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

if command -v kubectl >/dev/null 2>&1; then
    eval "$(kubectl completion bash)"
fi

# prompt
[ -r "$HOME/.bash_prompt" ] && [ -f "$HOME/.bash_prompt" ] && source "$HOME/.bash_prompt"

# completions
for file in `find ~/.bash_completion.d -maxdepth 1 -type f`; do
  . $file
done
