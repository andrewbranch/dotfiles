test -f $HOME/.bashrc && source $HOME/.bashrc
test -f $HOME/.profile && source $HOME/.profile

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
