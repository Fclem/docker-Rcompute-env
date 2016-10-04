#!/bin/bash
# run a fish terminal into the image configured in run_conf.sh (for checking, testing and debuging purposes)
# by default this is the latest image

source run_conf.sh

echo "Running docker image $run_img_name as container $container_name"
docker run -ti --rm -P --name $container_name \
	$run_img_name \
	/usr/bin/fish

