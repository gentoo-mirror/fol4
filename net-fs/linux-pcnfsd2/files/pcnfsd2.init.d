#!/sbin/openrc-run
# Copyright 1999-2004 Konstantin Münning
# Distributed under the terms of the GNU General Public License v2
# $Header: pcnfsd2.init.d,v 1.1 2003/02/22 22:41:09 vapier Exp $

depend() {
	need portmap
}

start() {
	ebegin "Starting pcnfsd2"
	start-stop-daemon --start --exec /usr/bin/rpc.pcnfsd
	eend $?
}

stop() {
	ebegin "Stopping pcnfsd2"
	start-stop-daemon --stop --exec /usr/bin/rpc.pcnfsd
	eend $?
}
