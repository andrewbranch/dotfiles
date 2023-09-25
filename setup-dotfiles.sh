#!/usr/bin/env bash

set -e

timestamp=`date +"%Y-%m-%d-%H_%M_%S"`
backup_dir=".dotfiles-backups/$timestamp"

echo "Linking files to home directory..."
for file in `find home -maxdepth 4 -type file`; do
    echo "$file"
    filepath=`grealpath $file`
    filename=`grealpath --relative-to=home $file`
    subdir=`dirname $filename`
    mkdir -p ~/$subdir
    target_dir=`grealpath ~/$subdir`
    backup_path="$HOME/$backup_dir/$filename"
    backup_subdir=`dirname $backup_path`
    if [ -e ~/$filename ] || [ -L ~/$filename ]; then
        if [ -L ~/$filename ]; then
            symlink_path=`grealpath ~/$filename`
            if [ $symlink_path != $filepath ]; then
                echo "'~/$filename' is a link from '$symlink_path'; relinking into '~/$backup_dir'"
                mkdir -p `dirname $backup_path`
                ln -s $symlink_path $backup_subdir/
                unlink ~/$filename
            else
                echo "'$filepath' is already linked into '$target_dir'; nothing to do"
                continue
            fi
        else
            echo "'~/$filename' already exists; moving into '~/$backup_dir'"
            mkdir -p $backup_subdir
            mv ~/$filename $backup_subdir/
        fi
    fi
    echo "Linking '$filepath' into '$target_dir'"
    mkdir -p `dirname $target_dir`
    ln -si $filepath $target_dir

    read -p "Press enter to continue"
done

# Completions
mkdir -p ~/.bash_completion.d
if ! [ -e ~/.bash_completion.d/git-completion.bash ]; then
    url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
    curl $url > ~/.bash_completion.d/git-completion.bash
fi

# GPG pinentry
mkdir -p $HOME/.gnupg
if ! [ -e ~/.gnupg/gpg-agent.conf ]; then
    echo "Configuring GPG pinentry-program"
    echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" > $HOME/.gnupg/gpg-agent.conf
    chmod 600 $HOME/.gnupg/gpg-agent.conf
    chmod 700 $HOME/.gnupg
else
    echo "GPG pinentry-program already configured"
fi

# /etc/hosts
if ! [ -e /etc/_hosts ]; then
    echo "Backing up /etc/hosts to /etc/_hosts"
    sudo cp /etc/hosts /etc/_hosts
    url="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
    echo "Downloading $url"
    curl $url | sudo tee /etc/hosts > /dev/null
else
    echo "/etc/hosts already configured"
fi
