#! bash

if [[ ! -d $CNI_CONF ]]; then
	echo "error: you have not set the env var CNI_CONF yet"
	exit 100
fi

if [[ $# -ne 2 ]]; then
	echo "error: method must have 2 args"
	echo "usage: $0 <subnet> <gateway>"
	echo "example: $0 10.10.10.0/24 10.10.10.1"
	exit 101
fi

cat > "$CNI_CONF/cni0.conf" << EOF
{
	"cniVersion": "0.4.0",
	"name": "cni0",
	"type": "bridge",
	"bridge": "cni0",
	"isDefaultGateway": true,
	"ipMasq": true,
	"ipam": {
		"type": "host-local",
		"ranges": [
			[
			{
				"subnet": "$1",
				"gateway": "$2"
			}
			]
		],
		"routes": [
			{
				"dst": "0.0.0.0/0"
			}
		]
	}
}

EOF

exit 0
