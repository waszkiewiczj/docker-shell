CONTAINER_ID="$(cat /proc/$$/cpuset | awk -F/ '{print substr($3,1,10)}')"


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


# proc
alias htop='docker run \
--rm \
--tty \
--interactive \
--pid host \
nixery.dev/htop 
htop'

alias ps='docker run \
--rm \
--pid host \
--volume /etc/passwd:/etc/passwd:ro \
nixery.dev/ps \
ps'


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

alias host='docker run \
--rm \
--net host \
nixery.dev/host \
host'


# vim
function vim() {
	docker run \
	--rm \
	--tty \
	--interactive \
	--env VIMINIT \
	--volumes-from ${CONTAINER_ID} \
	--volume ${HOME}:${HOME} \
	--workdir ${PWD} \
	--user $(id --user):$(id --group) \
	nixery.dev/shell/vim/vimplugins.onedark-vim \
	sh -c "stty cols $COLUMNS rows $LINES && vim --cmd 'set runtimepath+=/' `echo $@`"
}

# bat
function bat() {
	docker run \
	--rm \
	--tty \
	--interactive \
	--volume ${HOME}:${HOME}:ro \
	--workdir ${PWD} \
	nixery.dev/shell/bat \
	sh -c "stty cols $COLUMNS rows $LINES && bat `echo $@`"
}


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


# git
alias tig='docker run \
--rm \
--tty \
--interactive \
--volume ${HOME}:${HOME}:ro \
--workdir ${PWD} \
nixery.dev/tig \
tig'
