dl_cmd runi "create a new container from an image and run a command in it"
dl_runi() {
    IID=$1
    [ "$IID" ] || _dl_error "please specify image"
    shift
    IID=$(_dl_resolve images $IID)
    CID=$(dl_mkc $IID)
    dl_runc $CID "$@"
}