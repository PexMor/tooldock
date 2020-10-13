#!/bin/bash

echo "to be executed outside container"

echo "-=[ make the contaier netns visible to iproute"
[ -d /var/run/netns ] || mkdir -p /var/run/netns
ln -sfT /proc/$CONT_PID/ns/net /var/run/netns/$CONT_NAME
echo "-=[ check that namespace exists"
ip netns ls
