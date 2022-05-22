#! bash

if [[ $UID -ne 0 ]]; then
	echo "error: permission denied"
	exit 100
fi

if [[ $# -ne 2 ]]; then
	echo "error: method must have 2 args"
	echo "usage: $0 <name> <namespace>"
	echo "example: $0 app1 /var/run/netns/app1"
	exit 101
fi

CNI_COMMAND=ADD CNI_CONTAINERID=$1 CNI_NETNS=$2 CNI_IFNAME=eth0 $CNI_PATH/bridge <$CNI_CONF/cni0.conf
if [[ $? -ne 0 ]]; then
	echo "error: could not add $1"
	exit 103
fi

exit 0

