#!/bin/bash
source data/conf.sh
NAME='test_light2'
echo "Building $IMG ..."
docker build -t $IMG ~/docker/r-flight/
echo "docker build exit"
