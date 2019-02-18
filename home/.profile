# yarn
command -v foo >/dev/null 2>&1 && export PATH="$PATH:`yarn global bin`"

# Haskell
export PATH="/Users/Andrew/.local/bin:$PATH"

# Azure CLI completions
. ~/.azure.completion.sh

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
