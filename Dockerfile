# syntax=docker/dockerfile:1.3
FROM debian:bullseye-slim

ENTRYPOINT ["/config/docker-entrypoint.sh"]
ENV ZDOTDIR="/config"

ARG NIX_VERSION=2.3.15
RUN \
--mount=type="cache",target="/var/lib/apt/lists" \
--mount=type="cache",target="/nix-tmp" \
--mount=type="bind",target="install_nix.sh",target="/install_nix.sh" \
["/install_nix.sh"]

COPY ["config", "/config"]
