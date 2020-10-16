#!/bin/bash

NETNS_NAME=ns-bash
VETH_HOST=hbash
VETH_CONT=cbash

echo "UID=$UID"
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

NETNS_FIND=`ip netns list | grep "${NETNS_NAME}"`
if [ -z "${NETNS_FIND}" ]; then
	echo "-=[ create network namespace"
	ip netns add "${NETNS_NAME}"
else
	echo "-=[ netns alread exists (to remove: ip netns del ${NETNS_NAME})"
fi
if [ ! -f "/sys/devices/virtual/net/${VETH_HOST}" ]; then
	echo "-=[ create veth pair"
	ip link add ${VETH_HOST} type veth peer name ${VETH_CONT}
else
	echo "-=[ veth pair already exists (to remove: ip a fl dev $VETH_HOST, ip li set down dev $VETH_HOST, ip li del dev $VETH_HOST)"
fi
echo "-=[ set the devices online"
# FIXME: check the state of vNic
ip link set up dev ${VETH_HOST}

echo "-=[ move the container end nic to the container netns"
# FIXME: check whether needed (exec device existence inside netns, or read link-netns from /sys)
ip link set ${VETH_CONT} netns ${NETNS_NAME}

echo "-=[ set the $VETH_CONT up inside container"
# FIXME: check the state of vNic
ip netns exec ${NETNS_NAME} ip link set up dev ${VETH_CONT}
ip netns exec ${NETNS_NAME} ip link set up dev lo

# Here is the place where custom config should happen
# place them to following file (not part of git)
# for example check custom_ns_bash.sh-example
[ -f "custom_ns_bash.sh" ] && source custom_ns_bash.sh

echo "-=[ jump into namespace"
echo 'source $HOME/.bashrc' >~/.ns-bashrc-tmp
echo 'export PS1="[netns]$PS1"' >>~/.ns-bashrc-tmp
echo 'alias ip="ip -c"' >>~/.ns-bashrc-tmp
echo 'alias ip="ip -c"' >>~/.ns-bashrc-tmp
ip netns exec ${NETNS_NAME} /bin/bash --rcfile ~/.ns-bashrc-tmp
