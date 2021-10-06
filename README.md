# Docker Shell                          

![release](https://github.com/waszkiewiczj/docker-shell/actions/workflows/release.yml/badge.svg)
![master](https://github.com/waszkiewiczj/docker-shell/actions/workflows/master.yml/badge.svg)
[![GitHub release](https://img.shields.io/github/release/waszkiewiczj/docker-shell.svg)](https://GitHub.com/waszkiewiczj/docker-shell/releases)


Fully-functional shell environment with multiple development tools run completely inside Docker container!

## Why?

I am a huge Docker fan and I love the idea when I am able to run some currently required software inside a container and delete it right after usage instead of installing it bare-metal.

Some time ago I gave myself a challenge - how much I can *dockerize* (basically run it inside Docker container instead of bare-metal) tools that I use daily?
I achieved to run `git`, `vim`, `bat` and many more until an idea came to my mind... why can't I put **whole shell** inside container?

In this way I achieved a functionall shell environment that is extremely easy to migrate between machines and works out-of-the-box without long-term configuration.


## Installation & Run

This is the most beautiful fact - you don't need to install it!

This solution requires only Docker engine running on host machine and Linux-based operating system.

To run it, simply execute `docker-shell.sh` script:
```bash
sh -c "$(curl -fsSL https://github.com/waszkiewiczj/docker-shell/releases/latest/download/docker-shell.sh)" 
```

## How it works?

When `docker-shell.sh` is executed, it runs `docker-shell` container in privileged mode in host network and process namespace - it allows container to access a lot of information about host machine.

In entrypoint script, `docker-shell` resolves host user name via mounted host user `$HOME` directory (it assumes that name of directory and username are the same), resolves host user `$UID` and `$GID` and uses it to generate host-like user with `sudo` and `docker` group membership.

You should also notice very strage hostname displayed on prompt - it is current container ID. Thanks to that you can easily know in which container you are working right now. 

## Included tools

Image has plenty of included tools inside, like:
- ZSH shell with beautiful [Powerline style prompt](https://github.com/justjanne/powerline-go)
- Vim with [OneDark theme](https://github.com/joshdick/onedark.vim)
- Git with a lot of aliases included
- Docker CLI and [Hadolint](https://github.com/hadolint/hadolint)
- Kubectl and [K9s](https://k9scli.io/)
- and many, many more...

## Compatibility

To be perfectly honest, this is my private and made only out of passion project. That's why it can be not compatible with every environment possible. 
It is also made with purpose of working on Linux systems to use all the abilities of Docker engine ran bare-metal and not with Docker Desktop, so suport for MacOS/Windows is very unlikely to happen.
I personally use it daily on Ubuntu operating system and this is the platform that I am mostly focused on.

If you ever notice any bug and have any idea for improvements, feel free to contribute!


## Useful links

- Repository: https://github.com/waszkiewiczj/docker-shell
- Container registry: https://hub.docker.com/r/waszkiewiczj/docker-shell
