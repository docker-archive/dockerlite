dl_cmd diff "show differences between a container and its base image"
dl_diff () {
    CID=$1
    [ "$CID" ] || _dl_error "must specify container to diff"
    cd $DOCKERLITE_ROOT
    CID=$(_dl_resolve containers $CID)
    IID=$(_dl_getc $CID image)
    GEN=$(btrfs subvol list . | grep "path images/$IID/rootfs" | cut -d" " -f4)
    _dl_warning "btrfs find-new does not show deleted files or metadata changes"
    btrfs subvol find-new containers/$CID/rootfs $GEN | \
	grep -v ^transid | \
	cut -d" " -f17 | \
	sed 's/^/* /'
}