dl_cmd rootfs "show root fs of a container"
dl_rootfs () {
    CID=$1
    [ "$1" ] || error "must specify container"
    CID=$(_dl_resolve containers $CID)
    [ -d $DOCKERLITE_ROOT/containers/$CID ] || error "container does not exist"
    echo $DOCKERLITE_ROOT/containers/$CID/rootfs
}