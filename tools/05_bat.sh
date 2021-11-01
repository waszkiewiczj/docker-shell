#!/bin/sh
set -e

apt-get install --yes bat=0.12.1-6+b2

BAT_LOCATION="$(which batcat)"

mv "${BAT_LOCATION}" "$(dirname ${BAT_LOCATION})/bat"
