# pull an image from the docker registry (BROKEN)
dl_pull () {
    _dl_error "sorry, this code is broken for now"
    TAG=$1
    LATEST=$(_dl_curl library/$TAG | grep '"latest"' | cut -d\" -f4)
    CID=$(dl_mkc $(_dl_zerohash) pull-$TAG-$LATEST)
    _dl_layerpull $CID $LATEST
}

_dl_curl () {
    curl --location --silent https://index.docker.io/v1/$1
}

_dl_jsonextract () {
    KEY=$1
    $(_dl_sourcedir)/JSON.sh -b | grep -F '["'$KEY'"]' | awk '{print $2}'
}

_dl_layerpull () {
    CID=$1
    LAYER=$2
    _dl_info "looking at layer $LAYER"
    PARENT=$(_dl_curl images/$LAYER/json | _dl_jsonextract parent)
    if [ "$PARENT" ]
    then
	_dl_info "parent is $PARENT"
	_dl_layerpull $CID $PARENT
    else
	_dl_info "no parent"
    fi
    _dl_info "getting data..."
    _dl_curl images/$LAYER/layer | tee /tmp/debug | \
	tar -C $DOCKERLITE_ROOT/containers/$CID/rootfs -zxf-
}
