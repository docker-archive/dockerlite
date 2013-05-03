# get a shell in a container (without containerization)
dl_chroot () {
    CID=$1
    [ "$1" ] || error "must specify container to chroot to"
    chroot $(dl_rootfs $CID)
}