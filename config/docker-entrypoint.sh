#!/bin/bash
set -e

# create docker group
if [[ -f "/var/run/docker.sock" ]]; then
    HOST_DOCKER_GID="$(stat --format '%g' /var/run/docker.sock)"
    groupadd --gid ${HOST_DOCKER_GID} docker
else
    echo "WARNING: No docker socket mounted!"
fi

# create host-like user
HOST_USER="$(find /home -mindepth 1 -maxdepth 1 -type d | head --lines 1)"

if [[ -n "${HOST_USER}" ]]; then
    HOST_HOME_DIR="/home/${HOST_USER}"
    HOST_UID="$(stat --format '%u' ${HOST_HOME_DIR})"

    if [[ "${HOST_UID}" == "0" ]]; then
        useradd \
            --uid ${HOST_UID} \
            --home-dir ${HOST_HOME_DIR} \
            --shell /bin/zsh \
            --groups sudo \
            ${HOST_USER}

        if [[ $(cat /etc/group | grep --quiet docker) ]]; then
            usermod --groups docker ${HOST_USER}
        fi

        # change ower of all configs to host-like user
        chown --recursive "${HOST_USER}:${HOST_USER}" /config
    else
        echo "WARNING: User ID cannot be 0, no user will be created"
        HOST_USER="root"
    fi
else
    echo "WARNING: No home directory for user mounted!"
    HOST_USER="root"
fi

su --shell /bin/zsh "${HOST_USER}"
