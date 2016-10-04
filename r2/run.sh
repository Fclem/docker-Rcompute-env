#!/bin/bash

source run_conf.sh

NAME="Rtest"
echo "Running docker image $full_img_name as container $NAME"
docker run -ti --rm -P --name $NAME \
	$full_img_name \
	/usr/bin/fish

