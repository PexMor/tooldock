#!/bin/bash

source 00cfg
source 00mkDirs.sh

docker run -dt \
    --name=$DINST \
    --hostname=$DINST \
    --cap-add=CAP_NET_ADMIN \
    --user "$(id -u):$(id -g)" \
    --network none \
    -v $BD/home:/home \
    -v $BD/share:/share \
    $DIMG
