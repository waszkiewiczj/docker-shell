#!/bin/bash

DOCKER_SHELL_RELEASE_VERSION="latest"
DOCKER_SHELL_REGISTRY="ghcr.io/waszkiewiczj/docker-shell"
DOCKER_SHELL_BASE_TAG="${DOCKER_SHELL_REGISTRY}:${DOCKER_SHELL_RELEASE_VERSION}"

# parameters for local build
DOCKER_SHELL_VERSION=""
DOCKER_SHELL_TARGET="regular"
DOCKER_SHELL_BUILD="false"
DOCKER_SHELL_CONTEXT="$(dirname $0)"


function usage() {
	echo "Run shell inside docker container."
	echo "Usage:"
	echo "run.sh [--slim] [--local|--dev]"
	echo ""
	echo "Options"
	echo "-d, --dev   - run development version"
	echo "-l, --local - build & run local version"
	echo "-s, --slim  - run slim version"
}


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
		-h|--help)
			usage
			exit 0;
			;;
		*)
			echo "$1 is not a recognized flag!"
			usage
			exit 1;
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

