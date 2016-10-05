# this file contains configuraiton on how versioning will be done
# inits the version file to 0
# compiles the image full name (with tag prefix and version number suffix) into img_full_name
source build_conf.sh

rel_path=`dirname "${BASH_SOURCE}/"`/
if [ ! -f $rel_path.version ];
then
	touch $rel_path.version
	echo 0>$rel_path.version
fi
version=$(<$rel_path.version)
img_full_name=$repo_name/$img_name:$tag$version

# term colors
END_C="\e[0m"
RED="\e[91m"
L_CYAN="\e[96m"
L_YELL="\e[93m"
GREEN="\e[32m"
BOLD="\e[1m"
