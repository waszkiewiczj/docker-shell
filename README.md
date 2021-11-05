# Docker Shell                          

![master](https://github.com/waszkiewiczj/docker-shell/actions/workflows/master.yml/badge.svg)
[![release](https://img.shields.io/github/release/waszkiewiczj/docker-shell.svg)](https://GitHub.com/waszkiewiczj/docker-shell/releases)
[![license](https://img.shields.io/github/license/waszkiewiczj/docker-shell.svg)](https://GitHub.com/waszkiewiczj/docker-shell/releases)


**Fully-functional shell environment with multiple development tools run inside docker container!**

## Why?

I am a huge Docker fan and I love the idea of being able to run some software inside a container and delete it right after usage instead of installing it bare-metal.

Some time ago I gave myself a challenge - how many tools that I use daily can be  *dockerized* (ran inside docker container instead of bare-metal)?
I achieved to run some of most important ones to me (like `git`, `vim`, `bat` and many more) until an idea came to my mind... why can't I put **whole shell** inside container?

In this way I achieved a functionall shell environment that is extremely easy to migrate between machines and works out-of-the-box without long-term configuration.


## Installation & Run

This is the most beautiful fact - you don't need to install it!

This solution requires only Docker engine running on host machine and Linux-based operating system.

To run it, simply download and execute start script by running:
```bash
bash -c "$(curl -fsSL https://github.com/waszkiewiczj/docker-shell/releases/latest/download/run.sh)" 
```

## Included tools

Image has plenty of included tools inside, like:
- ZSH shell with [Oh My ZSH](https://ohmyz.sh/) and [Powerline10K](https://github.com/romkatv/powerlevel10k) prompt
- Vim with [OneDark theme](https://github.com/joshdick/onedark.vim)
- Docker CLI with [hadolint](https://github.com/hadolint/hadolint)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/) and [k9s](https://k9scli.io/)
- and many, many more...

## Slim version

Image comes also in *slim* version, which has almost the same functionality as regular one while being much smaller. It differs in those aspects:
- docker CLI is not installed - instead image has docker cli binary copied from [official Docker image](https://hub.docker.com/_/docker)
- *non-core tools* are also not installed, but are defined by shell aliases and ran as separate docker containers (special thanks to [Nixery](https://nixery.dev/) project)

## Compatibility

This is my private and made only out of passion project. That's why it can be not compatible with every environment possible. 
It is also made with purpose of working on Linux systems to use all the abilities of Docker engine ran bare-metal and not with Docker Desktop, so suport for MacOS/Windows is very unlikely to happen.
I personally use it daily on Ubuntu operating system and this is the platform that I am mostly focused on.


**If you notice any bug or have idea for improvement - feel free to contribute!**
