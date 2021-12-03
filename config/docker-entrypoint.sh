#!/bin/bash
set -e

# create docker group
if [[ -S "/var/run/docker.sock" ]]; then
    HOST_DOCKER_GID="$(stat --format '%g' /var/run/docker.sock)"

    if [[ "${HOST_DOCKER_GID}" != "0" ]]; then
        groupadd --gid "${HOST_DOCKER_GID}" docker
    else
        echo "WARNING: docker group ID cannot be 0, no group created"
    fi
else
    echo "WARNING: No docker socket mounted!"
fi

# create host-like user
MOUNT_HOST_HOME_DIR="$(find /mnt/host/home -mindepth 1 -maxdepth 1 -type d | head --lines 1)"

if [[ -n "${MOUNT_HOST_HOME_DIR}" ]]; then
    HOST_USER="$(echo "${MOUNT_HOST_HOME_DIR}" | cut --delimiter '/' --fields 5)"
    HOST_UID="$(stat --format '%u' "${MOUNT_HOST_HOME_DIR}")"

    if [[ "${HOST_UID}" != "0" ]]; then
        HOST_HOME_DIR="/home/${HOST_USER}"
        ln --symbolic "${MOUNT_HOST_HOME_DIR}" "${HOST_HOME_DIR}"
        
        useradd \
            --uid "${HOST_UID}" \
            --home-dir "${HOST_HOME_DIR}" \
            --shell /bin/zsh \
            --groups sudo \
            "${HOST_USER}"

        if grep --quiet docker /etc/group; then
            usermod --append --groups docker "${HOST_USER}"
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

cd "${HOST_HOME_DIR:-/root}"
su --shell /bin/zsh "${HOST_USER}"
