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

# compress a video file
function cmp() {
  base=`echo $1 | rev | cut -d. -f2 | rev`
  ext="mp4"
  cmd="ffmpeg -i \"$1\" -c:v libx264 -preset veryslow -crf 24 \"$base.cmp.$ext\""
  echo $cmd
  echo ""
  nag eval "$cmd" && du -h "$base.cmp.$ext"
}

function fix_delay() {
  base=`echo $1 | rev | cut -d. -f2 | rev`
  ext="mp4"
  cmd="ffmpeg -ss $2 -i \"$1\" -i \"$1\" -map 0:0 -map 1:1 -acodec copy -vcodec copy \"$base.fixed.$ext\""
  echo $cmd
  echo ""
  nag eval "$cmd"
}


# TypeScript shortcuts
alias bldiff="git diff --diff-filter=AM --no-index ./tests/baselines/reference ./tests/baselines/local"
alias bla="npx gulp baseline-accept"
alias t="npx gulp runtests --lint=false"
alias tp="npx gulp runtests-parallel --lint=false"

# Work and not work
function jobs() {
  open -a "Microsoft Teams"
  open -a "Visual Studio Code - Insiders"
  open -a "Safari" "https://github.com/notifications"
  open -a "Microsoft Outlook"
}
function no() {
  if [[ "$1" = "more"  &&  "$2" = "jobs" ]]; then
    cd ~
    osascript -e 'quit application "Microsoft Outlook"'
    osascript -e 'quit application "Visual Studio Code - Insiders"'
    osascript -e 'quit application "Microsoft Teams"'
    osascript -e 'quit application "Microsoft AutoUpdate"'
    
    SCRIPT=`cat <<EOF
      set urls to {"github.com", "microsoft.com", "azure.com", "office.com", "unpkg.com", "npm.com"}
      tell application "Safari"
        repeat with w in (every window)
          repeat with u in urls
            close (every tab of w whose url contains u)
          end repeat
        end repeat
      end tell
    EOF`
    osascript -e $SCRIPT > /dev/null
  fi 
}

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
