_dl_cmd lsc "list containers"
_dl_lsc () {
    cd $DOCKERLITE_ROOT/containers
    printf "%-40s %-30s %-30s\n" "CONTAINER ID" "CONTAINER NAME" "BASE IMAGE"
    for CID in *
    do
	IID=$(_dl_getc $CID image)
	printf "%-40s %-30s %-30s\n" \
	    $CID "$(_dl_getc $CID name)" "$(_dl_geti $IID name)"
    done
}
