# check if a container is running
dl_running () {
    CID=$1
    [ "$CID" ] || _dl_error "must specify container"
    CID=$(_dl_resolve containers $CID)
    TASKS=$(_dl_cgroup $CID nonfatal)/tasks
    if [ -f $TASKS ]
    then 
	echo Y
	return 0
    else
	echo N
	return 1
    fi
}