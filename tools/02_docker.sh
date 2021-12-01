#!/bin/sh
set -e

apt-get install --yes \
gnupg=2.2.27-2 \
lsb-release=11.1.0

curl \
--fail \
--silent \
--show-error \
--location \
"https://download.docker.com/linux/debian/gpg" \
| gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install --yes docker-ce-cli=5:20.10.10~3-0~debian-bullseye


curl \
--fail \
--silent \
--show-error \
--location \
--create-dirs \
--output "/usr/bin/hadolint" \
"https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64"

chmod +x "/usr/bin/hadolint"
