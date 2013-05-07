dl_cmd findpid "find pid of a process within given container"
dl_findpid () {
    CID=$1
    [ "$CID" ] || _dl_error "must specify container"
    CID=$(_dl_resolve containers $CID)
    TASKS=$(_dl_cgroup $CID)/tasks
    PID=$(head -n 1 $TASKS)
    [ "$PID" ] || _dl_error "cgroup seems to be empty"
    echo $PID
}