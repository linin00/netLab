#! bash

if [[ $UID -ne 0 ]]; then
	echo 'permission denied'
	exit 100
fi

if [[ $# -ne 3 ]]; then
	echo "usage: bash $0 <ip> <gateway> <hostname>"
	echo "example: bash $0 192.168.146.180/24 192.168.146.2 lab000lj"
	exit 101
fi

hostnamectl 'set-hostname' $3

# /etc/netplan/00-installer-config.yaml
cat > '/etc/netplan/00-installer-config.yaml' << EOF
# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
  version: 2
  renderer: networkd
  ethernets:
    ens33:
     dhcp4: no
     addresses:
      - $1
     gateway4: $2
     nameservers:
      addresses:
      - 8.8.8.8
EOF

netplan apply

exit 0
