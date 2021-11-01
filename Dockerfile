# syntax=docker/dockerfile:1.3
FROM debian:bullseye-slim as base

ENTRYPOINT ["/config/docker-entrypoint.sh"]

ENV TERM=xterm-256color \
ZDOTDIR="/config" \
ZSH="/config/oh-my-zsh" \
ZSH_CUSTOM="/config/zsh-custom"

COPY ["config", "/config"]

RUN --mount=type="bind",source="core",target="/core" \
set -e && for script in $(find /core -type f -name *.sh | sort); do $script; done


FROM base as slim

COPY [".tools.sh", "/config/.tools.sh"]


FROM base

RUN --mount=type="bind",source="tools",target="/tools" \
set -e && for script in $(find /tools -type f -name *.sh | sort); do $script; done
