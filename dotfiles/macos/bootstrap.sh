#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit

git pull origin master


sync_files() {
    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude "README.md" \
        --exclude "LICENSE-MIT.txt" \
        --exclude "bootstrap.sh" \
        -avh --no-perms . ~
    source ~/.zshrc
}


if [[ "$1" == "--force" || "$1" == "-f" ]]; then
    sync_files
else
    echo -n "Это может перезаписать существующие файлы в вашей домашней директории. Вы уверены? (y/n) "
    read reply
    if [[ "$reply" == "y" || "$reply" == "Y" ]]; then
        sync_files
    fi
fi
