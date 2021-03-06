#!/usr/bin/env bash

set -e

realpath() {
    echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

timestamp=`date +"%Y-%m-%d-%H_%M_%S"`
backup_dir=".dotfiles-backups/$timestamp"

echo "Linking files to home directory..."
for file in `find home -maxdepth 1 -type file`; do
    filepath=`realpath $file`
    filename=`basename $file`
    if [ -e ~/$filename ] || [ -L ~/$filename ]; then
        if [ -L ~/$filename ]; then
            symlink_path=`realpath ~/$filename`
            if [ $symlink_path != $filepath ]; then
                echo "'~/$filename' is a symlink to '$symlink_path'; relinking into '~/$backup_dir'"
                mkdir -p "$HOME/$backup_dir"
                ln -s $symlink_path ~/$backup_dir/
                unlink ~/$filename
            else
                echo "'~/$filename' is already linked to here; nothing to do"
                continue
            fi
        else
            echo "'~/$filename' already exists; moving into '~/$backup_dir'"
            mkdir -p "$HOME/$backup_dir"
            mv ~/$filename ~$backup_dir/
        fi
    fi
    ln -si $filepath ~
done

# Completions
mkdir -p ~/.bash_completion.d
if ! [ -e ~/.bash_completion.d/git-completion.bash ]; then
    url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
    curl $url > ~/.bash_completion.d/git-completion.bash
fi
