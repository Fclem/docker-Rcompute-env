#!/bin/bash

source build_conf.sh

((version++))

docker build -t $repo_name/$img_name from-r2/
echo ${version}>.version
docker tag $repo_name/$img_name $img_full_name
docker images $repo_name/$img_name
