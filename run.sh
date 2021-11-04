#!/bin/bash

DOCKER_SHELL_REGISTRY="ghcr.io/waszkiewiczj/docker-shell"
DOCKER_SHELL_BASE_TAG="${DOCKER_SHELL_REGISTRY}:latest"

# parameters for local build
DOCKER_SHELL_VERSION=""
DOCKER_SHELL_TARGET="regular"
DOCKER_SHELL_BUILD="false"
DOCKER_SHELL_CONTEXT="$(dirname $0)"


while test $# -gt 0; do
	case "$1" in
		-d|--dev)
			DOCKER_SHELL_BASE_TAG="${DOCKER_SHELL_REGISTRY}:dev"
			shift
			;;
		-s|--slim)
			DOCKER_SHELL_VERSION="-slim"
			DOCKER_SHELL_TARGET="slim"
			shift
			;;
		-l|--local)
			DOCKER_SHELL_BUILD="true"
			DOCKER_SHELL_BASE_TAG="docker-shell"
			shift
			;;
		*)
			echo "$1 is not a recognized flag!"
			return 1;
			;;
	esac
done


DOCKER_SHELL_TAG="${DOCKER_SHELL_BASE_TAG}${DOCKER_SHELL_VERSION}"


if [[ "${DOCKER_SHELL_BUILD}" == "true" ]]; then
	DOCKER_BUILDKIT=1 \
	docker build \
	--progress plain \
	--target ${DOCKER_SHELL_TARGET} \
	--tag ${DOCKER_SHELL_TAG} \
	${DOCKER_SHELL_CONTEXT}
fi


docker run \
--rm \
--interactive \
--tty \
--privileged \
--net host \
--pid host \
--volume "${HOME}:${HOME}" \
--volume "/var/run/docker.sock:/var/run/docker.sock" \
--env DISPLAY \
"${DOCKER_SHELL_TAG}"

