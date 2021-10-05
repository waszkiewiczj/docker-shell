#!/bin/sh

# create docker group
HOST_DOCKER_GID="$(stat --format '%g' /var/run/docker.sock)"
groupadd --gid "${HOST_DOCKER_GID}" "docker"

# create host-like user
HOST_USER="$(ls /home | head -n 1)"
HOST_HOME_DIR="/home/${HOST_USER}"
HOST_UID="$(stat --format '%u' ${HOST_HOME_DIR})"

useradd \
    --uid "${HOST_UID}" \
    --home-dir "${HOST_HOME_DIR}" \
    --shell "/bin/zsh" \
    --groups sudo,docker \
    "${HOST_USER}"

# change ower of all configs to host-like user
chown --recursive "${HOST_USER}:${HOST_USER}" /config

# switch to host-like user
cd "${HOST_HOME_DIR}"
su --whitelist-environment ZDOTDIR,VIMINIT "${HOST_USER}"
