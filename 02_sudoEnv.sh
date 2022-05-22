#! bash
if [[ $UID -ne 0 ]]; then
    echo "you must be root user"
	exit 100
fi

sed -i.bak '/Defaults/s/!*env_reset$/!env_reset/' /etc/sudoers

exit 0
