_dl_cmd lsa "list ip addresses allocated to containers"
_dl_lsa () {
    cd $DOCKERLITE_ROOT/networks
    ls
}

_dl_gateway () {
    echo 10.1.1.1
}

_dl_allocateipaddr () {
    CID=$1
    cd $DOCKERLITE_ROOT
    [ -d containers/$CID/metadata ] || \
	_dl_error "cannot allocate addr for $CID (not found)"
    PREFIX=10.1.1
    FIRST=2
    LAST=255
    for SUFFIX in $(seq $FIRST $LAST)
    do 
	mkdir networks/$PREFIX.$SUFFIX 2>/dev/null || continue
	echo $CID > networks/$PREFIX.$SUFFIX/cid
	_dl_setc $CID ipaddr $PREFIX.$SUFFIX/24
	echo $PREFIX.$SUFFIX/24
	return
    done
    _dl_error "could not allocate addr (network full?)"
}

_dl_setipaddr () {
    CID=$1
    IPADDR=$2
    cd $DOCKERLITE_ROOT
    [ -d containers/$CID/metadata ] || \
	_dl_error "cannot allocate addr for $CID (not found)"
    mkdir networks/$IPADDR 2>/dev/null || _dl_error "address already in use"
    echo $CID > networks/$IPADDR/cid
    _dl_setc $CID ipaddr $IPADDR/24
}

_dl_cmd seta "manually allocate ip address to container"
_dl_seta () {
    CID=$1
    IPADDR=$2
    [ "$CID" ] || _dl_error "must specify container"
    CID=$(_dl_resolve containers $CID)
    if [ "$IPADDR" ]
    then _dl_setipaddr $CID $IPADDR
    else _dl_allocateipaddr $CID
    fi
}