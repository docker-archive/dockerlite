# First Steps With Dockerlite


## Installation

Clone the repository anywhere you like, e.g.:

```bash
cd /opt
git clone git://github.com/jpetazzo/dockerlite
```

Then you can either add `/opt/dockerlite` to your `$PATH`, or
create a symlink to `/opt/dockerlite/dockerlite`, e.g.:

```bash
ln -s /opt/dockerlite/dockerlite /usr/local/sbin/dockerlite
```

**Note:** Dockerlite requires root privileges. It needs to do call the BTRFS
tools, the LXC tools, and manipulate network interfaces; all that stuff
requires root privileges.


## BTRFS requirements

You need a BTRFS filesystem in `/btrfs`. There are three main different
ways to do that.


### If your root filesystem in on BTRFS

Then just create a subvolume in `/btrfs` with `btrfs subvol create btrfs`.
You're done.


### If you have a spare block device or some space on your LVM VG

Format the spare device/partition/LV using BTRFS and mount it on `/btrfs`.


### If you have none of those

Loopback to the rescue!

```bash
$ sudo -i
dd if=/dev/zero of=/btrfs.img bs=1024k count=1 seek=2048
mkfs -t btrfs /btrfs.img
mount -o loop /btrfs.img /btrfs
```


## One-time initialization of Dockerlite

Just run `dockerlite init` and you're done.

