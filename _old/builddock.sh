#!/bin/bash
source data/conf-r-fimm.sh
echo "Building $IMG ..."
docker build -t $IMG ~/docker/r-up/
echo "docker build exit"
