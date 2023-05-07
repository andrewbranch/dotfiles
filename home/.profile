export BREW_PREFIX=$(brew --prefix)

# colors
export CLICOLOR=1
export TERM="xterm-color"

# less
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --quiet --force --style ekvoli"
export LESS=' -R -X -F '
alias more='less'

# Use GNU tar
export PATH="$(brew --prefix)/opt/gnu-tar/libexec/gnubin:$PATH"

# serve current directory on port 8000
function http() {
  python -m http.server
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

alias code="code-insiders"

# TypeScript shortcuts
alias bldiff="git diff --diff-filter=AM --no-index ./tests/baselines/reference ./tests/baselines/local"
alias bla="npx hereby baseline-accept"
alias t="npx hereby runtests --no-typecheck"
alias tp="npx hereby runtests-parallel"

# Work and not work
function jobs() {
  open -a "Microsoft Teams"
  code
  open -a "Safari" "https://github.com/notifications"
  open -a "Microsoft Outlook"
}
function no() {
  if [[ "$1" = "more"  &&  "$2" = "jobs" ]]; then
    cd ~
    osascript -e 'quit application "Microsoft Outlook"'
    osascript -e 'quit application "Visual Studio Code"'
    osascript -e 'quit application "Visual Studio Code - Insiders"'
    osascript -e 'quit application "Microsoft Teams"'
    osascript -e 'quit application "Microsoft AutoUpdate"'
    
    SCRIPT=`cat <<EOF
      set urls to {"github.com", "microsoft.com", "azure.com", "office.com", "unpkg.com", "npm.com", "typescriptlang.org", "nodejs.org"}
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
