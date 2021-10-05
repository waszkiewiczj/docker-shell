#!/bin/sh

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
	docker-shell
