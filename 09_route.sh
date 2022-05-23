#! bash

if [[ $UID -ne 0 ]]; then
	echo "error: permission denied"
	exit 100
fi

if [[ $# -ne 2 ]]; then
	echo "error: method must has 2 args"
	echo "usage: $0 <subnet> <ip>"
	echo "example: $0 10.10.10.0/24 191.168.146.181"
	exit 101
fi

route add -net $1 gw $2
exit 0
