#! bash

if [[ $UID -ne 0 ]]; then
	echo "error: permission denied"
	exit 100
fi
if [[ $# -ne 1 ]]; then
	echo "error: method must has 1 arg"
	echo "usage: $0 <logfile path>"
	echo "example: $0 /home/linin/debug.log"
	exit 101
fi

cat > /etc/rsyslog.d/debug.conf << EOF
kern.* $1
EOF

/etc/init.d/rsyslog restart
