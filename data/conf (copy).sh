#!/bin/bash
NAME='test_auto'
IMG_NAME='r-light'
IMG_TAG='op'
IMG='fimm/'$IMG_NAME':'$IMG_TAG
#IMG='fimm/r-fimm'
V_PATH=/home/cloud-user/docker/data
DOCK_HOME=/breeze
echo "path is $V_PATH"
#	-v /home/cloud-user/docker/libs/:/usr/local/lib/R/library \
#	-v /home/cloud-user/docker/r-up/libs/:/usr/local/lib/R/ext-library \
