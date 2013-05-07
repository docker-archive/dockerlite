# terminate a runaway container
dl_kill () {
    CID=$1
    [ "$CID" ] || _dl_error "must specify container to kill"
    CID=$(_dl_resolve containers $CID)
    lxc-stop -n $CID
}