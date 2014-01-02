# Dockerlite: lightweight Linux virtualization with BTRFS and LXC

Dockerlite lets you run Linux apps in lightweight, isolated environments,
using LXC (Linux Containers). It is inspired by [Docker](http://www.docker.io/)
and it actually reimplements some of its most basic features.

Using BTRFS snapshots, `dockerlite` can save the state of a given environment
in a frozen "image", and later, create more environments ("containers") out
of that image.

It was inspired by [Docker](https://www.docker.io/), and aims at being
a sandbox to experiment new concepts linked with the Docker project.

It is **not** a replacement for Docker. It is **missing** (at least)
the following features:
- registry protocol (i.e. it is not possible to push/pull images)
- index protocol (i.e. it is not possible to search images)
- REST API (i.e. the only way to use Dockerlite is through the CLI)
- Dockerfile (i.e. you cannot `dockerlite build`)
- and many more.

Its main feature is `HACKABILITY: 9000` since it's shell, and everybody
including your dog can write shell scripts, right?


## Installation

See [INSTALL.md](INSTALL.md).


## How to use it

See [MANUAL.md](MANUAL.md).


## What's "lightweight" virtualization?

A Linux container looks like a virtual machine: it has its own network stack,
IP address, process space; it is isolated from its sibling containers (it can't
see them and can't be seen by them). However, it runs on top of the same
kernel as its host. This means that if your machine runs Linux 3.8, all
containers on this machine will also run Linux 3.8. You cannot run another
kernel (or another OS) within a container. Of course, you could run a full
virtual machine within qemu or kvm within a container, but that's a different
story!


## Where the name `dockerlite` comes from?

`dockerlite` is a "light" version of [Docker](/dotcloud/docker).
The latter has similar features, but with the following major differences:
- Docker is written in Go, while `dockerlite` is a Posix Shell script;
- Docker storage relies on AUFS, while `dockerlite` uses BTRFS;
- Docker runs as a background daemon, and is operated through a CLI
  client, while `dockerlite` does not run in the background.

Docker also has some extra features to store images in 3rd party services.


## Why `dockerlite`?

`dockerlite` initially targetted the following goals:
- demonstrate that the core features provided by Docker can be easily
  reimplemented with simple, easy-to-audit, shell scripts;
- provide an alternative implementation to Docker, with a strong emphasis
  on "hackability", i.e. a lightweight testbed for new features which can
  be more cumbersome to implement in a full-blown Go project;
- evaluate BTRFS in the context of Docker.

The first goal is loosely defined, depending on what you want to put in
the "core features" of Docker. If you just want to create images and
containers, then "misson complete". If you want to push/pull and use
a REST API, it's a long shot.

The other goals were met. Dockerlite confirmed that BTRFS was an acceptable
option and that there were no unplanned side-effect or shotstopper
preventing its use for Docker containers. It also served to evaluate
different ways to setup the containers networking stack.


## License

Apache 2 License

For JSON.sh license, see https://github.com/dominictarr/JSON.sh
