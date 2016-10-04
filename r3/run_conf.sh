# configure the desired container name for run.sh here
# and the image version to run (the latest by default)
source common.sh
# local path
local_root_path=`pwd`
# image to run
run_img_name=$repo_name/$img_name # :tag
# created container name
container_name="a_test" # Edit to any relevant content

