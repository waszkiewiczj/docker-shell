#!/bin/sh
set -e

curl \
--fail \
--silent \
--show-error \
--location \
--create-dirs \
--output "/usr/local/bin/kubectl" \
"https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl"

chmod +x "/usr/local/bin/kubectl"


curl \
--fail \
--silent \
--show-error \
--location \
--create-dirs \
"https://webinstall.dev/k9s" | bash

mv "/root/.local/bin/k9s" "/usr/bin/"


curl \
--fail \
--silent \
--show-error \
--location \
--create-dirs \
--output "/tmp/kubeval.tar.gz" \
"https://github.com/instrumenta/kubeval/releases/download/v0.16.1/kubeval-linux-amd64.tar.gz"

tar --extract --directory "/usr/local/bin" --file "/tmp/kubeval.tar.gz"
