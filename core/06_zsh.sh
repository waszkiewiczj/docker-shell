#!/bin/sh
set -e

apt-get install --yes zsh=5.8-6+b2

OH_MY_ZSH_INSTALL="/tmp/install-oh-my-zsh.sh"

curl \
--fail \
--silent \
--show-error \
--location \
--output "${OH_MY_ZSH_INSTALL}" \
"https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"

chmod +x "${OH_MY_ZSH_INSTALL}"
sh "${OH_MY_ZSH_INSTALL}"

git clone \
--depth=1 "https://github.com/romkatv/powerlevel10k.git" \
"${ZSH_CUSTOM}/themes/powerlevel10k"
