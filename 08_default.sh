#! bash
if [[ $UID -ne 0 ]]; then
	echo "error: permission denied"
	exit 100
fi
iptables -t filter -P FORWARD ACCEPT
