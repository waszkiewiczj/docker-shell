#!/bin/sh

DEBIAN_FRONTEND="noninteractive"

# make docker entrypoint executable
chmod +x "/config/docker-entrypoint.sh"

# reconfigure dpkg to enable man pages
# ref: https://unix.stackexchange.com/questions/480459/docker-debianstretch-slim-install-man-and-view-manpages
sed --in-place '/path-exclude \/usr\/share\/man/d' /etc/dpkg/dpkg.cfg.d/docker
sed --in-place '/path-exclude \/usr\/share\/groff/d' /etc/dpkg/dpkg.cfg.d/docker

# install requirements
apt-get update
apt-get install --yes \
    bat=0.12.1-6+b2 \
    curl=7.74.0-1.3+b1 \
    figlet=2.2.5-3+b1 \
    fzf=0.24.3-1+b6 \
    git=1:2.30.2-1 \
    lolcat=100.0.1-3 \
    jq=1.6-2.1 \
    man-db=2.9.4-2 \
    manpages-dev=5.10-1 \
    manpages=5.10-1 \
    net-tools=1.60+git20181103.0eebece-1 \
    nfs-common=1:1.3.4-6 \
    procps=2:3.3.17-5 \
    sudo=1.9.5p2-3 \
    tig=2.5.1-1 \
    vim=2:8.2.2434-3 \
    xclip=0.13-2 \
    zsh=5.8-6+b2
rm --recursive --force /var/lib/apt/lists/*

# copy additional binaries
cp /additional-bin/* "/usr/local/bin/"

# install kubectl
KUBECTL_VER="1.22.0"
KUBECTL_BIN_URL="https://dl.k8s.io/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl"
curl \
    --fail \
    --silent \
    --show-error \
    --location \
    --create-dirs \
    --output "/usr/local/bin/kubectl" \
    "${KUBECTL_BIN_URL}"
chmod +x "/usr/local/bin/kubectl"

# setup sudo
cat <<EOF >/etc/sudoers
root    ALL=(ALL:ALL) ALL
%sudo   ALL=(ALL:ALL) NOPASSWD:ALL
EOF

# download powerlne go zsh theme
POWERLINE_GO_VER="1.21.0"
POWERLINE_GO_BIN_URL="https://github.com/justjanne/powerline-go/releases/download/v${POWERLINE_GO_VER}/powerline-go-linux-amd64"
curl \
    --fail \
    --silent \
    --show-error \
    --location \
    --create-dirs \
    --output "/bin/powerline-go" \
    "${POWERLINE_GO_BIN_URL}"
chmod +x "/bin/powerline-go"

# install onedark vim theme
ONEDARK_VIM_BASE_URL="https://raw.githubusercontent.com/joshdick/onedark.vim/main"
curl \
    --fail \
    --silent \
    --show-error \
    --location \
    --create-dirs \
    --output "/config/.vim/colors/onedark.vim" \
    "${ONEDARK_VIM_BASE_URL}/colors/onedark.vim"
curl \
    --fail \
    --silent \
    --show-error \
    --location \
    --create-dirs \
    --output "/config/.vim/autoload/onedark.vim" \
    "${ONEDARK_VIM_BASE_URL}/autoload/onedark.vim"
