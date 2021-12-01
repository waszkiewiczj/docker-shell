#!/bin/bash

DOCKER_SHELL_RELEASE_VERSION="latest"
DOCKER_SHELL_REGISTRY="ghcr.io/waszkiewiczj/docker-shell"
DOCKER_SHELL_BASE_TAG="${DOCKER_SHELL_REGISTRY}:${DOCKER_SHELL_RELEASE_VERSION}"

# parameters for local build
DOCKER_SHELL_VERSION=""
DOCKER_SHELL_TARGET="regular"
DOCKER_SHELL_BUILD="false"


function usage() {
	echo "Run shell inside docker container."
	echo "Usage:"
	echo "run.sh [--slim] [--local|--dev|--tag]"
	echo ""
	echo "Options"
	echo "-s, --slim  - run slim version"
	echo "-l, --local - build & run local version"
	echo "-d, --dev   - run development version"
	echo "-t, --tag   - run specific version"
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
		-t|--tag)
			DOCKER_SHELL_BASE_TAG="${DOCKER_SHELL_REGISTRY}:$2"
			shift 2
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
	if [[ ! -f "$0" ]] || [[ ! -f "$(dirname "$0")/Dockerfile" ]]; then
		echo "ERROR: You need to clone whole repository to build local version"
		exit 1
	fi
	DOCKER_SHELL_CONTEXT="$(dirname "$0")"

	DOCKER_BUILDKIT=1 \
	docker build \
	--progress plain \
	--target "${DOCKER_SHELL_TARGET}" \
	--tag "${DOCKER_SHELL_TAG}" \
	"${DOCKER_SHELL_CONTEXT}"
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

