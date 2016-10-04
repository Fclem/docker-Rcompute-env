#!/bin/bash
# does the build, increment the version number and rotate old latest version
source common.sh

((version++))

docker build -t $repo_name/$img_name $build_source/
echo ${version}>.version
docker tag $repo_name/$img_name $img_full_name
docker images $repo_name/$img_name

