# bash coloring helpers
username=${USER}
END_C="\e[0m"
RED="\e[91m"
L_CYAN="\e[96m"
BOLD_GREEN="\e[1;32m"
L_YELL="\e[93m"
GREEN="\e[32m"
BOLD="\e[1m"
SHDOL=${GREEN}${BOLD}"$"${END_C}" "

function print_and_do(){
	echo -e $SHDOL$1
	eval $1
}

function print_already(){
	echo -e $L_YELL"Already exists : "$1${END_C}
}

function print_created(){
	echo -e $L_CYAN"created : "$1${END_C}
}

function create_if_non_existent(){ # arg1 is folder to test, arg2 is a folder, or space separated list to pass to mkdir
	# second arg is optional and will be filled with first if absent
	sec="$2"
	if [ "" = "${sec}" ]; then
		sec="$1"
	fi
	# creates folders if non existent
	if [ ! -d "$1" ] ; then
		mkdir -p ${sec} && \
	    print_created ${sec}
	else
		print_already $1
	fi
}

# # # # # # # #
# env defined #
# # # # # # # #

# DOCKER SOURCES
apt_docker_key_server="hkp://ha.pool.sks-keyservers.net:80"
apt_docker_key_id="58118E89F3A912897C070ADBF76221572C52609D"
apt_docker_repo="https://apt.dockerproject.org/repo"

# FOLDER STRUCTURE CONFIGS
home_folder="/root"
cloud_proj_folder='/data'
ph_proj_folder='/data-ph'

locale_gen='en_US.UTF-8'
time_zone="Europe/Helsinki"

# init.sh generated :
