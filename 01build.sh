#!/bin/bash

source 00cfg

if [ "x$(uname -s)" = "xDarwin" ]; then
  # https://www.martin-brennan.com/set-timezone-from-terminal-osx/
  TZLINK=`readlink /etc/localtime`
  BA_TZ=${TZLINK##/var/db/timezone/zoneinfo/}
  # BA_TZ=`sudo systemsetup -gettimezone | tr -d " " | cut -d: -f2`
else
  BA_TZ=`timedatectl | grep "Time zone" | tr -d " " | tr "()" ":" | cut -d: -f2`
  # BA_TZ="Europe/Prague"
  # BA_TZ="US/Pacific"
fi

docker build \
    --build-arg BA_UID=`id -u` \
    --build-arg BA_GID=`id -g` \
    --build-arg BA_TZ="$BA_TZ" \
    -t $DIMG .
