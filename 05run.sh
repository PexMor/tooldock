#!/bin/bash

source 00cfg
source 00mkDirs.sh
source 00colors.inc

echo "---"
printf "BaseDirectory: ${Yellow}$BD${Color_Off}\n"
printf "        Image: ${Blue}$DIMG${Color_Off}\n"
printf "     Instance: ${Green}$DINST${Color_Off}\n"
echo "---"
docker inspect $DINST >/dev/null 2>&1
RC=$?
if [ $RC -eq 0 ]; then
    printf "${Red}Instance '${DINST}' already running${Color_Off}\n"
    printf "${Green}You can remove the instance using '99killNrm.sh'${Color_Off}\n"
    exit -1
else
    printf "${Green}Starting${Color_Off}\n"
fi
docker run -dt \
    --name=$DINST \
    --hostname=$DINST \
    --cap-add=NET_ADMIN \
    --user "$(id -u):$(id -g)" \
    -v $BD/home:/home \
    -v $BD/share:/share \
    $DIMG
