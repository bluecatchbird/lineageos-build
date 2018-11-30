#!/bin/bash

set -e
set -x 
set -o pipefail

ID=$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM
docker build \
       -t $ID \
       --build-arg UID=$(id -u) \
       --build-arg GID=$(id -g) \
       .

SHARED=$(pwd)/output/
if [ ! -d "$SHARED" ]
then
    mkdir -p $SHARED
    chmod ugo+rwx
fi

docker run -i -t --user $(id -u):$(id -g) --rm --workdir /opt/android/lineage -v $SHARED:/opt $ID /build.sh

docker rmi $ID
