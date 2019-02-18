# LESSPIPE=`which src-hilite-lesspipe.sh`
# export LESSOPEN="| ${LESSPIPE} %s"
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --quiet --force --style ekvoli"
export LESS=' -R -X -F '
alias more='less'

# bash completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

if command -v kubectl >/dev/null 2>&1; then
    eval "$(kubectl completion bash)"
fi

# colors
export CLICOLOR=1
export TERM="xterm-color"
PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$ '

# prompt
[ -r "$HOME/.bash_prompt" ] && [ -f "$HOME/.bash_prompt" ] && source "$HOME/.bash_prompt"

# Add git branch as env variable
b () {
    echo "$(command git symbolic-ref --quiet --short HEAD 2> /dev/null || command git rev-parse --short HEAD 2> /dev/null || echo '')"
}

# Copy file to clipboard
cpc () {
  osascript \
    -e 'on run args' \
    -e 'set the clipboard to POSIX file (first item of args)' \
    -e end \
    "$@"
}

# print a system bell after the task exits
nag () {
  $@;
  echo -e "\a";
}

# secret things
test -f ./bash_secrets && source ./bash_secrets

# completions
for file in `find ~/.bash_completion.d -maxdepth 1 -type file`; do
  . $file
done
