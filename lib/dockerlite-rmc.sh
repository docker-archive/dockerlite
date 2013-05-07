# destroy a container
dl_rmc () {
    CID=$1
    [ "$CID" ] || _dl_error "must specify container ID"
    CID=$(_dl_resolve containers $CID)
    cd $DOCKERLITE_ROOT
    _dl_btrfs subvol delete containers/$CID/rootfs
    rm -rf containers/$CID
}