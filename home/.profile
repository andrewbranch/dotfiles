# colors
export CLICOLOR=1
export TERM="xterm-color"

# less
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --quiet --force --style ekvoli"
export LESS=' -R -X -F '
alias more='less'

# Use GNU tar
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

# Python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
if [ -n `which python` ]; then
  export PATH="`python -m site --user-base`/bin:$PATH"
fi

# yarn
command -v foo >/dev/null 2>&1 && export PATH="$PATH:`yarn global bin`"

# Haskell
export PATH="/Users/Andrew/.local/bin:$PATH"

# Azure CLI completions
. ~/.azure.completion.sh

# Hass
alias hass=hass-cli

function up() {
  hass service call --arguments entity_id=media_player.43_tcl_roku_tv media_player.volume_up > /dev/null
  [ $? -ne 0 ] && return 1
  (for ((i=1; i < ${1:-1}; i++)); do
    set -e
    hass service call --arguments entity_id=media_player.43_tcl_roku_tv media_player.volume_up > /dev/null
  done &) > /dev/null
  echo '🎸'
}

function down() {
  hass service call --arguments entity_id=media_player.43_tcl_roku_tv media_player.volume_down > /dev/null
  [ $? -ne 0 ] && return 1
  (for ((i=1; i < ${1:-1}; i++)); do
    set -e
    hass service call --arguments entity_id=media_player.43_tcl_roku_tv media_player.volume_down > /dev/null
  done &) > /dev/null
  echo '🤫'
}

# hub alias
command -v hub >/dev/null 2>&1 && eval "$(hub alias -s)"

# serve current directory on port 8000
function http() {
  dir=${1%/}
  docker run -v $dir:/tmp/share -p 8000:8000 ksmithorn97/gzip-http-file-server
}

# kill whatever is on a given port
function killport() {
  lsof -i tcp:$1 -Fp | head -n 1 | cut -f 2 -d p | xargs kill -9
}

# screen capture after 5 seconds, sending output to clipboard
alias sc="screencapture -c"

# clean git branches
alias git-clean-branches='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

# toggle adware host blocking
function hosts() {
  sudo mv /etc/hosts  /etc/_hosts
  sudo mv /etc/.hosts /etc/hosts
  sudo mv /etc/_hosts /etc/.hosts
}

# secret things
test -f ~/.secrets && source ~/.secrets

# Copy file to clipboard
function cpc () {
  osascript \
    -e 'on run args' \
    -e 'set the clipboard to POSIX file (first item of args)' \
    -e end \
    "$@"
}

# print a system bell after the task exits
function nag () {
  $@;
  echo -e "\a";
}
