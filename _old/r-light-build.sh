#!/bin/bash
source data/conf.sh
IMG='fimm/r-light'
NAME='test_light'
echo "Building $IMG ..."
docker build -t $IMG ~/docker/r-light/
echo "docker build exit"
