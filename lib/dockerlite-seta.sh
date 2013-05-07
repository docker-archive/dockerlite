dl_cmd seta "manually allocate ip address to container"
dl_seta () {
    CID=$1
    IPADDR=$2
    [ "$CID" ] || _dl_error "must specify container"
    CID=$(_dl_resolve containers $CID)
    if [ "$IPADDR" ]
    then _dl_setipaddr $CID $IPADDR
    else _dl_allocateipaddr $CID
    fi
}