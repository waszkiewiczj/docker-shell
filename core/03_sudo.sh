#!/bin/sh

apt-get install --yes sudo=1.9.5p2-3

cat <<EOF >/etc/sudoers
root    ALL=(ALL:ALL) ALL
%sudo   ALL=(ALL:ALL) NOPASSWD:ALL
EOF
