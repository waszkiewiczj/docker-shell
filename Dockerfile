# syntax=docker/dockerfile:1.3
FROM debian:bullseye-slim as base

ENTRYPOINT ["/config/docker-entrypoint.sh"]

VOLUME /config

ENV DOCKER_BUILDKIT=1 \
TERM=xterm-256color \
ZDOTDIR="/config" \
ZSH="/config/oh-my-zsh" \
ZSH_CUSTOM="/config/zsh-custom"

COPY ["config", "/config"]

RUN --mount=type=bind,source=core,target=/core \
set -e && for script in $(find /core -type f -name *.sh | sort); do $script; done


FROM base as slim

COPY --from="docker:20.10.8-alpine3.14" ["/usr/local/bin/docker", "/usr/bin/docker"]

COPY [".tools.sh", "/config/.tools.sh"]


FROM base as regular

RUN --mount=type=bind,source=tools,target=/tools \
set -e && for script in $(find /tools -type f -name *.sh | sort); do $script; done
