#!/bin/sh
set -e

apt-get install --yes zsh=5.8-6+b2

OH_MY_ZSH_INSTALL="/install-oh-my-zsh.sh"

curl \
--fail \
--silent \
--show-error \
--location \
--output "${OH_MY_ZSH_INSTALL}" \
"https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"

chmod +x "${OH_MY_ZSH_INSTALL}"
sh "${OH_MY_ZSH_INSTALL}"

rm "${OH_MY_ZSH_INSTALL}"

git clone \
--depth=1 "https://github.com/romkatv/powerlevel10k.git" \
"${ZSH_CUSTOM}/themes/powerlevel10k"

${ZSH_CUSTOM}/themes/powerlevel10k/gitstatus/build -s -w -d docker

# GITSTATUSD_ARCHIVE="gitstatusd-linux-x86_64.tar.gz"
# curl \
# --fail \
# --silent \
# --show-error \
# --location \
# --output "/tmp/${GITSTATUSD_ARCHIVE}" \
# "https://github.com/romkatv/gitstatus/releases/download/v1.5.1/${GITSTATUSD_ARCHIVE}"

# GITSTATUSD_DIR="${ZSH_CUSTOM}/themes/powerlevel10k/gitstatus/usrbin"
# tar --extract \
# --directory "${GITSTATUSD_DIR}" \
# --file "/tmp/${GITSTATUSD_ARCHIVE}"

# mv "${GITSTATUSD_DIR}/gitstatusd-linux-x86_64" "${GITSTATUSD_DIR}/gitstatusd"

# rm /tmp/${GITSTATUSD_ARCHIVE}
