_dl_cmd ps "list containers and their runtime information"
_dl_ps () {
    cd $DOCKERLITE_ROOT/containers
    printf "%-8s %-30s %-40s %-30s %-30s %-30s %s\n" "ID" "CONTAINER NAME" "BASE IMAGE" "CREATED" "STARTED" "CMD" "RUNNING"
    for CID in $(ls -t)
    do
	SHORTCID=$(echo $CID | cut -c1-8)
	IID=$(_dl_getc $CID image)
	printf "%-8s %-30s %-40s %-30s %-30s %-30s %s\n" \
	    $SHORTCID "$(_dl_getc $CID name)" "$(_dl_geti $IID name)" \
	    "$(_dl_getc $CID ctime)" "$(_dl_getc $CID rtime)" \
	    "$(_dl_getc $CID cmd)" "$(_dl_running $CID)"
    done
}
