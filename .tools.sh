# htop
alias htop='docker run \
--rm \
--tty \
--interactive \
--pid host \
nixery.dev/htop htop'


# net tools
alias iftop='docker run \
--rm \
--tty \
--interactive \
--net host \
nixery.dev/iftop iftop'
