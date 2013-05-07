# `dockerlite`: lightweight Linux virtualization with BTRFS and LXC

`dockerlite` lets you run Linux apps in lightweight, isolated environments,
using LXC (Linux Containers).

Using BTRFS snapshots, `dockerlite` can save the state of a given environment
in a frozen "image", and later, create more environments ("containers") out
of that image.


## Installation

See INSTALL.md.


## How to use it

See MANUAL.md.


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

`dockerlite` is a "light" version of [`docker`](/dotcloud/docker).
The latter has similar features, but with the following major differences:
- `docker` is written in Go, while `dockerlite` is a Posix Shell script;
- `docker` storage relies on AUFS, while `dockerlite` uses BTRFS;
- `docker` runs as a background daemon, and is operated through a CLI
  client, while `dockerlite` does not run in the background.

`docker` also has some extra features to store images in 3rd party services.


## Why `dockerlite`?

`dockerlite` initially addressed the following goals:
- demonstrate that the core features provided by `docker` can be easily
  reimplemented with simple, easy-to-audit, shell scripts;
- provide an alternative implementation to `docker`, with a strong emphasis
  on "hackability", i.e. a lightweight testbed for new features which can
  be more cumbersome to implement in a full-blown Go project;
- evaluate BTRFS in the context of `docker`.


## License

Apache 2 License

For JSON.sh license, see https://github.com/dominictarr/JSON.sh
