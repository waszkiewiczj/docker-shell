# syntax=docker/dockerfile:1.3
FROM debian:bullseye-slim as base

ENTRYPOINT ["/config/docker-entrypoint.sh"]

SHELL ["/bin/bash", "-e", "-o", "pipefail", "-c"]

VOLUME /config

ENV DOCKER_BUILDKIT=1 \
TERM=xterm-256color \
ZDOTDIR="/config" \
ZSH="/config/oh-my-zsh" \
ZSH_CUSTOM="/config/zsh-custom"

COPY ["config", "/config"]

RUN --mount=type=bind,source=core,target=/core \
for script in $(find /core -type f -name "*.sh" | sort); do $script; done


FROM base as slim

COPY --from="docker:20.10.8-alpine3.14" ["/usr/local/bin/docker", "/usr/bin/docker"]

COPY [".toolsrc", "/config/"]


FROM base as regular

SHELL ["/bin/bash", "-e", "-o", "pipefail", "-c"]

RUN --mount=type=bind,source=tools,target=/tools \
for script in $(find /tools -type f -name "*.sh" | sort); do $script; done
