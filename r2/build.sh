#!/bin/bash

source build_conf.sh

((version++))

docker build -t $repo_name/$img_name $build_source/
echo ${version}>.version
docker tag $repo_name/$img_name $img_full_name
docker images $repo_name/$img_name

