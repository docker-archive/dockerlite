_dl_cmd rmi "destroy a container"
_dl_rmi () {
    IID=$1
    [ "$IID" ] || _dl_error "must specify image to destroy"
    IID=$(_dl_resolve images $IID)
    cd $DOCKERLITE_ROOT
    _dl_btrfs subvol delete images/$IID/rootfs
    rm -rf images/$IID
}