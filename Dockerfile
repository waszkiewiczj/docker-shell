# syntax=docker/dockerfile:1.3
FROM debian:bullseye-slim

ENTRYPOINT ["/config/docker-entrypoint.sh"]
ENV ZDOTDIR="/config"

COPY ["config", "/config"]
RUN \
--mount=type=bind,source="setup.sh",target="/setup.sh" \
--mount=type=bind,from="docker:20.10.8-alpine3.14",source="/usr/local/bin/docker",target="/additional-bin/docker" \
["/setup.sh"]
