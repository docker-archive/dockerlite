_dl_cmd init "initialize $DOCKERLITE_ROOT and create the root (empty) image"
_dl_init () {
    # If for some reason, we cannot "vendor in" JSON.sh, we could download
    # it here, when the image store is initialized.
    #curl -s https://raw.github.com/dominictarr/JSON.sh/master/JSON.sh > JSON.sh
    #chmod +x JSON.sh

    cd $DOCKERLITE_ROOT
    mkdir -p images
    mkdir -p containers
    mkdir -p networks

    EMPTY=empty$RANDOM
    ZEROHASH=$(_dl_zerohash)
    _dl_btrfs subvol create $EMPTY
    mkdir -p images/$ZEROHASH
    mkdir -p images/$ZEROHASH/metadata
    _dl_seti $ZEROHASH name 'empty image (base of all other images)'
    _dl_btrfs subvol snapshot -r $EMPTY images/$ZEROHASH/rootfs
    _dl_btrfs subvol delete $EMPTY
}

_dl_mkloop () {
    [ -d $DOCKERLITE_ROOT ] || mkdir -p $DOCKERLITE_ROOT
    mountpoint -q $DOCKERLITE_ROOT && return
    [ -f $DOCKERLITE_LOOPFILE ] || {
	dd if=/dev/zero of=$DOCKERLITE_LOOPFILE bs=1024k count=$DOCKERLITE_LOOPSIZE
	mkfs -t btrfs $DOCKERLITE_LOOPFILE
    }
    mount $DOCKERLITE_LOOPFILE $DOCKERLITE_ROOT
}
