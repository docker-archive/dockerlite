_dl_cmd chroot "get a shell in a container (without containerization)"
_dl_chroot () {
    CID=$1
    [ "$1" ] || error "must specify container to chroot to"
    chroot $(_dl_rootfs $CID)
}