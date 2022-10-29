test -f $HOME/.bashrc && source $HOME/.bashrc
test -f $HOME/.profile && source $HOME/.profile

# hass-cli completions
. <(hass-cli completion bash)

###-begin-cf-completions-###
#
# yargs command completion script
#
# Installation: /usr/local/bin/cf completion >> ~/.bashrc
#    or /usr/local/bin/cf completion >> ~/.bash_profile on OSX.
#
_yargs_completions()
{
    local cur_word args type_list

    cur_word="${COMP_WORDS[COMP_CWORD]}"
    args=("${COMP_WORDS[@]}")

    # ask yargs to generate completions.
    type_list=$(/usr/local/bin/cf --get-yargs-completions "${args[@]}")

    COMPREPLY=( $(compgen -W "${type_list}" -- ${cur_word}) )

    # if no match was found, fall back to filename completion
    if [ ${#COMPREPLY[@]} -eq 0 ]; then
      COMPREPLY=( $(compgen -f -- "${cur_word}" ) )
    fi

    return 0
}
complete -F _yargs_completions cf
###-end-cf-completions-###

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
