# run a command in an existing container
dl_runc () {
    CID=$1
    CMD=$2
    cd $DOCKERLITE_ROOT
    [ "$CID" ] || _dl_error "please specify container to run"
    CID=$(_dl_resolve containers $CID)
    shift
    if [ "$CMD" ]
    then shift
    else CMD=/bin/bash
    fi
    
    cat > containers/$CID/lxc <<EOF
lxc.utsname=$CID
lxc.tty=1
lxc.console=none
lxc.rootfs=$DOCKERLITE_ROOT/containers/$CID/rootfs
lxc.network.type=veth
lxc.network.flags=up
lxc.network.link=$DOCKERLITE_BRIDGE
lxc.network.name=eth0
lxc.network.ipv4=0.0.0.0
lxc.cgroup.devices.deny=a
# /dev/null /dev/zero
lxc.cgroup.devices.allow=c 1:3 rwm
lxc.cgroup.devices.allow=c 1:5 rwm
# consoles
lxc.cgroup.devices.allow=c 5:1 rwm
lxc.cgroup.devices.allow=c 5:0 rwm
lxc.cgroup.devices.allow=c 4:0 rwm
lxc.cgroup.devices.allow=c 4:1 rwm
# /dev/{,u}random
lxc.cgroup.devices.allow=c 1:9 rwm
lxc.cgroup.devices.allow=c 1:8 rwm
# pts
lxc.cgroup.devices.allow=c 136:* rwm
lxc.cgroup.devices.allow=c 5:2 rwm
# /dev/net/tun
lxc.cgroup.devices.allow=c 10:200 rwm
# /dev/fuse
lxc.cgroup.devices.allow=c 10:229 rwm
# rtc
lxc.cgroup.devices.allow=c 254:0 rwm
EOF
    
    if [ -f containers/$CID/rootfs/etc/resolv.conf ]
    then
	echo "lxc.mount.entry=/etc/resolv.conf $DOCKERLITE_ROOT/containers/$CID/rootfs/etc/resolv.conf none defaults,bind,ro 0 0" >> containers/$CID/lxc
    else
	_dl_warning "no /etc/resolv.conf in container"
    fi

    if [ -f containers/$CID/rootfs/bin/true ]
    then
	echo "lxc.mount.entry=$(_dl_sourcedir)/true $DOCKERLITE_ROOT/containers/$CID/rootfs/bin/true none defaults,bind,ro 0 0" >> containers/$CID/lxc
    else
	_dl_warning "no /bin/true in container"
    fi

    which curl >/dev/null || _dl_error "curl not found, please install it first"

    (
	for RETRY in $(seq 1 10)
	do
	    sleep 1
	    PID=$(dl_findpid $CID 2>/dev/null) || continue
	    mkdir -p /var/run/netns
	    rm -f /var/run/netns/$CID
	    ln -s /proc/$PID/ns/net /var/run/netns/$CID
	    ip netns exec $CID ifconfig eth0 $(_dl_getc $CID ipaddr)
	    ip netns exec $CID route add default gw $(_dl_gateway)
	    ip netns exec $CID curl localhost:9 2>/dev/null
	    exit 0
	done
	_dl_error "could not setup networking stack"
    ) &

    _dl_setc $CID cmd "$CMD $*"
    _dl_setc $CID rtime "$(date)"

    lxc-start --name $CID --rcfile $DOCKERLITE_ROOT/containers/$CID/lxc -- \
	/bin/true --stop-hammer-time \
	env TERM=$TERM PATH=/usr/sbin:/usr/bin:/sbin:/bin HOME=/ \
	"$CMD" "$@"
}
