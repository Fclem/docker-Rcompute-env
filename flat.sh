#!/bin/bash
echo "Flattening base image.."
SRC=fimm/r-light:candidate
DST=fimm/r-light:new-flat
ID=$(docker run -d ${SRC} /bin/bash)
docker export $ID | docker import - ${DST}
