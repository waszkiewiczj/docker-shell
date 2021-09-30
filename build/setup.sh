#!/bin/sh

# install requirements
apk update
cat /build/requirements.txt | xargs apk add
rm -rf /var/cache/apk/*

# download powerlne go zsh theme
POWERLINE_BIN_URL="https://github.com/justjanne/powerline-go/releases/download/v1.21.0/powerline-go-linux-amd64"
curl -fsSLo "/bin/powerline-go" "${POWERLINE_BIN_URL}"
chmod +x "/bin/powerline-go"
