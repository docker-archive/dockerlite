# list images
dl_lsi () {
    cd $DOCKERLITE_ROOT/images
    for IID in *
    do
	echo $IID $(_dl_geti $IID name)
    done
}