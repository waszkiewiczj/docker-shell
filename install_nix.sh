#!/bin/sh

set -e

export DEBIAN_FRONTEND="noninteractive"

apt-get update apt-get install --yes curl=7.74.0-1.3+b1

NIX_URL="https://nixos.org/releases/nix/nix-${NIX_VERSION}/nix-${NIX_VERSION}-$(uname -m)-linux.tar.xz"
curl -fsSLo /nix-tmp/nix.tar.xz "${NIX_URL}"
tar -xf /nix-tmp/nix.tar.xz

mkdir -m 0755 /nix /etc/nix
echo "sandbox = false" > /etc/nix/nix.conf
sh /nix-tmp/nix/install
ln -s /nix/var/nix/profiles/default/etc/profile.d/nix.sh /etc/profile.d/
/nix/var/nix/profiles/default/bin/nix-collect-garbage --delete-old
/nix/var/nix/profiles/default/bin/nix-store --optimise
/nix/var/nix/profiles/default/bin/nix-store --verify --check-contents
