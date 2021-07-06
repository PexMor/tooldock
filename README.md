# Tooldock

Toolbox in a docker.

__Purpose:__ use docker as lightweight VM

__Use-cases:__

* multitude of VPNs (VPNs tends to override complete networking)
* run small portable apps (i.e. certmonger)

## General usage

Ingredients:

* the Docker installed
* the image (made by `01build.sh`)
* installed `tmux` (or `screen`)

### Inside the host terminal

You would need the running container and then attach to that container using multiple consoles.

1. start the container `./05run.sh`
2. start `tmux` session

### Life inside the tmux session

1. attach to the running container `./10exec.sh` - start interactive shell
2. attach to it again from second tmux pane (new pane `Ctrl + b and c`)
3. detach from the `tmux` and let it live in the background (detach: `Ctrl + b and d`, re-attach using `tmux a`)

> Note: to rename pane `Ctrl + b and ,`, to list sessions `tmux ls`

## Bash netns

This a small and independent script that let's you enter network namespace without need of containers. It utilizes the excelent tool of iproute2, which offers subcommand `netns`.

It consists of two files the main script `70netNsBash.sh` and the customization script `custom_ns_bash.sh` which __NOT__ part of the repo as it will be... well custom. But there is an example you can start with `custom_ns_bash.sh.example`.
