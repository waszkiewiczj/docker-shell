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


# vim
alias vim='docker run \
--rm \
--tty \
--interactive \
--env VIMINIT \
--volume /config/.vimrc:/config/.vimrc \
--volume ${HOME}:${HOME} \
nixery.dev/vim/vimplugins.onedark-vim \
vim --cmd "set runtimepath+=/"'
