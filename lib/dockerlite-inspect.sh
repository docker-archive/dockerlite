_dl_cmd inspect "show information about a container"
_dl_inspect () {
    CID=$1
    [ "$CID" ] || _dl_error "must specify container to inspect"
    CID=$(_dl_resolve containers $CID)
    cd $DOCKERLITE_ROOT/containers/$CID/metadata
    grep . *
}