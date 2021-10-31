#!/bin/sh
set -e

# ref: https://unix.stackexchange.com/questions/480459/docker-debianstretch-slim-install-man-and-view-manpages
sed \
--in-place '/path-exclude \/usr\/share\/man/d' \
/etc/dpkg/dpkg.cfg.d/docker

sed \
--in-place '/path-exclude \/usr\/share\/groff/d' \
/etc/dpkg/dpkg.cfg.d/docker

apt-get install --yes \
    man-db=2.9.4-2 \
    manpages-dev=5.10-1 \
    manpages=5.10-1
