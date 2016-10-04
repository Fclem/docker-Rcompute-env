source build_conf.sh

# DOCK_HOME=/breeze
# V_PATH=/home/cloud-user/docker/data

END_C="\e[0m"
RED="\e[91m"
L_CYAN="\e[96m"
L_YELL="\e[93m"
GREEN="\e[32m"

local_root_path=`pwd`

full_img_name=$repo_name/$img_name # no need for :$tag$version since we're using the default ':latest'

