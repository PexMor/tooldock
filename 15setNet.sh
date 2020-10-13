#!/bin/bash -x

source 00cfg

CONT_NAME=$DINST
HOST_NIC=h$DINST
CONT_NIC=c$DINST
CONT_MAC=02:00:00:00:00:01
CONT_PID=$(docker inspect --format '{{ .State.Pid }}' "$CONT_NAME" | tr -dc "0-9")

docker run -it --rm \
    --network host \
    --pid host \
    --privileged \
    -v $PWD:/share \
    nicolaka/netshoot \
    bash -x /share/netns/00_netCfg.sh $CONT_PID $CONT_NAME $HOST_NIC $CONT_NIC $CONT_MAC

# the commands below works in Linux only
#sudo bash netns/00_netOut.sh $CONT_NAME $HOST_NIC $CONT_NIC
#sudo ip netns exec $DINST bash netns/00_netOut.sh $CONT_NIC $CONT_MAC
