#!/bin/sh
set -e

apt-get install --yes vim=2:8.2.2434-3

for file in "colors/onedark.vim" "autoload/onedark.vim" 
do
    curl \
        --fail \
        --silent \
        --show-error \
        --location \
        --create-dirs \
        --output "/config/.vim/${file}" \
        "https://raw.githubusercontent.com/joshdick/onedark.vim/main/${file}"
done
