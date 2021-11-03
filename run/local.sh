#!/bin/bash

LOCAL_SCRIPT_LOCATION="$(dirname $0)"
DOCKER_SHELL_IMAGE_TAG="docker-shell"

DOCKER_BUILDKIT=1 docker build --progress plain --tag "${DOCKER_SHELL_IMAGE_TAG}" "${LOCAL_SCRIPT_LOCATION}/.."

if [[ -f "${LOCAL_SCRIPT_LOCATION}/template.sh" ]]; then
	source "${LOCAL_SCRIPT_LOCATION}/template.sh"
else
	echo "ERROR! No template script available!"
fi

