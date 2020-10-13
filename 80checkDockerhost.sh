#!/bin/bash -x

source 00cfg

export CONT_NAME=$DINST
export CONT_PID=$(docker inspect --format '{{ .State.Pid }}' "$CONT_NAME" | tr -dc "0-9")

docker run -it --rm \
    --network host \
    --pid host \
    --privileged \
    -e CONT_PID \
    -e CONT_NAME \
    -v $PWD:/share \
    nicolaka/netshoot \
