#!/bin/bash
source data/conf2.sh
NAME="shell"
echo "Running docker image $IMG as container $NAME"
docker run -ti --rm -P --name $NAME \
	-v $V_PATH:$DOCK_HOME \
	$IMG \
	/bin/bash

