#!/bin/bash

echo "to be executed inside container"

ip li set up dev $VETH_CONT
ip li set address $MAC dev $VETH_CONT
# setting ip address
# ip ad ad 192.168.101.33/24 dev $NIC_NAME
# ip ro ad default via 192.168.101.1
ip -c address
