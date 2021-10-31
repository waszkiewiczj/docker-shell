# syntax=docker/dockerfile:1.3
FROM debian:bullseye-slim as base

ENTRYPOINT ["/config/docker-entrypoint.sh"]

ENV TERM=xterm-256color \
ZDOTDIR="/config" \
ZSH="/config/oh-my-zsh" \
ZSH_CUSTOM="/config/zsh-custom"

COPY ["config", "/config"]

RUN --mount=type="bind",source="core",target="/core" \
--mount=type="bind",source="/var/run/docker.sock",target="/var/run/docker.sock" \
set -e && for script in $(find /core -type f -name *.sh | sort); do $script; done
