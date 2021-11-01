# docker
alias hadolint='docker run \
--rm \
--interactive \
--volume ${HOME}:${HOME} \
--workdir ${PWD} \
nixery.dev/hadolint \
hadolint'


# kubernetes
alias kubectl='docker run \
--rm \
--volume ${HOME}/.kube/config:/root/.kube/config \
--volume ${HOME}:${HOME} \
--workdir ${PWD} \
nixery.dev/kubectl \
kubectl'

alias k9s='docker run \
--rm \
--tty \
--interactive \
--net host \
--volume ${HOME}/.kube/config:/root/.kube/config \
nixery.dev/k9s \
k9s'

alias kubeval='docker run \
--rm \
--interactive \
--volume ${HOME}:${HOME} \
--workdir ${PWD} \
nixery.dev/kubeval \
kubeval'


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
--workdir ${PWD} \
nixery.dev/vim/vimplugins.onedark-vim \
vim --cmd "set runtimepath+=/"'


# bat
alias bat='docker run \
--rm \
--tty \
--interactive \
--volume ${HOME}:${HOME} \
--workdir ${PWD} \
nixery.dev/bat \
bat'


# fzf
alias fzf='docker run \
--rm \
--tty \
--interactive \
--volume ${HOME}:${HOME}:ro \
--workdir ${PWD} \
nixery.dev/bat/fzf
fzf'


# figlet
alias figlet='docker run \
--rm \
--interactive \
nixery.dev/figlet \
figlet'
