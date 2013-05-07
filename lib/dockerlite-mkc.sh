_dl_cmd mkc "create a new container from an image"
_dl_mkc () {
    IID=$1
    CNAME=$2
    [ "$IID" ] || _dl_error "must specify base image for container"
    IID=$(_dl_resolve images $IID)
    CID=$(_dl_mkid)
    cd $DOCKERLITE_ROOT
    mkdir containers/$CID containers/$CID/metadata
    _dl_setc $CID image $IID
    _dl_setc $CID ctime "$(date)"
    _dl_btrfs subvol snapshot images/$IID/rootfs containers/$CID/rootfs
    [ "$CNAME" ] && _dl_setc $CID name $CNAME
    _dl_allocateipaddr $CID >/dev/null
    echo $CID
}