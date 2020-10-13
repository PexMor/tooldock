#!/bin/bash

set -a
CONT_PID=$1
CONT_NAME=${2:-dummy}
VETH_HOST=${3:-host-$NAME}
VETH_CONT=${4:-cont-$NAME}
# dummy vendor - openstack borrowed
VEN=54:52:00
# MAC address to be set on veth pair
MAC=${5:-$VEN:00:00:01}
set +a

BD=/share/netns
source $BD/01_netPubNetNs.sh
source $BD/02_netOut.sh
ip netns exec $CONT_NAME bash -x $BD/03_netIn.sh