#!/bin/sh

DOCKER_SHELL_TAG="docker-shell"

DOCKER_BUILDKIT=1

docker build \
    --progress plain \
    --tag "${DOCKER_SHELL_TAG}" \
    .

docker run \
	--rm \
	--interactive \
	--tty \
	--privileged \
	--net host \
	--pid host \
	--volume "${HOME}:${HOME}" \
	--volume "/var/run/docker.sock:/var/run/docker.sock" \
	--env TERM \
	--env COLORTERM \
	--env DISPLAY \
	"${DOCKER_SHELL_TAG}"
