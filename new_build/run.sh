#!/bin/bash

source run_conf.sh

NAME="Rtest"
echo $full_img_name
echo "Running docker image $img_full_name as container $NAME"
docker run -ti --rm -P --name $NAME \
	$img_full_name \
	/bin/bash
