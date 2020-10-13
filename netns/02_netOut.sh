#!/bin/bash

echo "to be executed outside container"

echo "-=[ cleanup the veth pair"
ip link del ${VETH_HOST} || true
echo "-=[ create veth pair"
ip link add ${VETH_HOST} type veth peer name ${VETH_CONT}
echo "-=[ set the devices online"
ip link set up dev ${VETH_HOST}
ip link set up dev ${VETH_CONT}

echo "-=[ move the container end nic to the container netns"
ip link set ${VETH_CONT} netns ${CONT_NAME}

# OVSBR="mainBridge"
# ovs-vsctl --may-exist add-br "${OVSBR}"
# ovs-vsctl del-port "${OVSBR}" "${VETH_HOST}"
# ovs-vsctl --may-exist add-port "${OVSBR}" "${VETH_HOST}"
