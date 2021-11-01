# htop
alias htop='docker run \
--rm \
--tty \
--interactive \
--pid host \
nixery.dev/htop 
htop'


# net tools
alias iftop='docker run \
--rm \
--tty \
--interactive \
--net host \
nixery.dev/iftop 
iftop'

alias ip='docker run \
--rm \
--net host
nixery.dev/iproute2 
ip'

alias ifconfig='docker run \
--rm \
--net host \
nixery.dev/unixtools.ifconfig \
ifconfig'

alias netstat='docker run \
--rm \
--net host \
nixery.dev/unixtools.netstat \
netstat'


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
