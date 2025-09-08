# bash completion
if [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
    . "$(brew --prefix)/share/bash-completion/bash_completion"
fi

# completions
for file in `find ~/.bash_completion.d -maxdepth 1 -type f`; do
  . $file
done

eval "$(starship init bash)"
