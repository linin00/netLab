#! bash

if [[ $UID -ne 0 ]]; then
	echo "permission denied"
	exit 100
fi
if [[ $# -ne 2 || $1 != 'add' && $1 != 'del' ]]; then
	echo "error: usage: $0 add|del <ip>"
	echo "example: $0 add 10.10.10.0/24"
	exit 101
fi

if [[ $1 == 'add' ]]; then
	iptables -t filter -A INPUT -d $2 -j LOG --log-prefix		'[INPUT      ]: '
	iptables -t filter -A OUTPUT -d $2 -j LOG --log-prefix		'[OUTPUT     ]: '
	iptables -t filter -A FORWARD -d $2 -j LOG --log-prefix		'[FORWARD    ]: '
	iptables -t nat -A PREROUTING -d $2 -j LOG --log-prefix		'[PREROUTING ]: '
	iptables -t nat -A POSTROUTING -d $2 -j LOG --log-prefix	'[POSTROUTING]: '
else 
	iptables -t filter -D INPUT -d $2 -j LOG --log-prefix		'[INPUT      ]: '
	iptables -t filter -D OUTPUT -d $2 -j LOG --log-prefix		'[OUTPUT     ]: '
	iptables -t filter -D FORWARD -d $2 -j LOG --log-prefix		'[FORWARD    ]: '
	iptables -t nat -D PREROUTING -d $2 -j LOG --log-prefix		'[PREROUTING ]: '
	iptables -t nat -D POSTROUTING -d $2 -j LOG --log-prefix	'[POSTROUTING]: '
fi

exit 0
