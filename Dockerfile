# syntax=docker/dockerfile:1.3
FROM alpine:3.13.6

ENTRYPOINT ["/bin/zsh"]
ENV ZDOTDIR=/config MYVIMRC=/config/.vimrc

COPY config /config
RUN --mount=type=bind,source=build,target=/build ["/build/setup.sh"]
