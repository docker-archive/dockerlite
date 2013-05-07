_dl_cmd mki "create a new image from the state of a container"
_dl_mki () {
    cd "$DOCKERLITE_ROOT"
    CID=$1
    INAME=$2
    [ "$CID" ] || _dl_error "you must specify container ID to create an image"
    CID=$(_dl_resolve containers $CID)
    IID=$(_dl_mkid)
    mkdir images/$IID
    mkdir images/$IID/metadata
    _dl_seti $IID parent $CID
    _dl_seti $IID ctime "$(date)"
    _dl_btrfs subvol snapshot -r containers/$CID/rootfs images/$IID/rootfs
    [ "$INAME" ] && _dl_seti $IID name $INAME
}
