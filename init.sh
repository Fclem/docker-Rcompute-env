#!/usr/bin/env bash
local_root_path=$(readlink -f $(dirname "$0"))
source const.sh # IDE hack for var resolution
source ${local_root_path}/const.sh


# clem 10/08/2017
function check_sudo(){
	echo -e "${L_CYAN}Checking for root access ${END_C}(if prompted please enter the root password)${L_CYAN} ...${END_C}"
	sudo echo -e "${GREEN}OK${END_C}"
}

function create_folders_if_not_existant(){
	for var in "$@"
	do
		if [ ! -d "$var" ] ; then
			mkdir -p $var && print_created $var
		else
			print_already $var
		fi
	done
}

### check sudo access
check_sudo

### check if user is in docker group, adds it if not
username=${USER}
if getent group docker | grep &>/dev/null "\b${username}\b"; then
	echo -n -e "${L_YELL}${username} already in group docker"${END_C}
else
	print_and_do "sudo groupadd docker && sudo usermod -aG docker ${username}"
	echo -e "${L_YELL}${username} added to group docker, please log in again, and run " \
		"'${BOLD}cd docker && ./init.sh${END_C}${L_YELL}'"${END_C}
	logout 2>/dev/null
	exit
fi

echo
echo -e ${L_CYAN}"Init will now run fully unattended."${END_C}
echo "You should scroll through the log to make sure that everything goes smoothly"
echo

###
#  END OF ATTENDED PART
###

### Fix locale
sudo locale-gen ${locale_gen}
export LANGUAGE=${locale_gen}
export LANG=${locale_gen}
export LC_ALL=${locale_gen}
sudo locale-gen ${locale_gen}
# FIXME some issues with that and root rights...
sudo echo "${time_zone}" > /etc/timezone && \
	sudo dpkg-reconfigure -f noninteractive tzdata && \
	sed -i -e "s/# ${locale_gen} UTF-8/${locale_gen} UTF-8/" /etc/locale.gen && \
	sudo echo "LANG=\"${locale_gen}\"">/etc/default/locale && \
	sudo dpkg-reconfigure --frontend=noninteractive locales && \
	sudo update-locale LANG=${locale_gen}
### APT update
print_and_do "sudo apt-get update && sudo apt-get upgrade -y"
print_and_do "sudo apt-get install apt-transport-https ca-certificates"
### Get docker repos keys
print_and_do "sudo apt-key adv \
			--keyserver ${apt_docker_key_server} \
			--recv-keys ${apt_docker_key_id}"
### Add apt docker repo
print_and_do "echo 'deb ${apt_docker_repo} ubuntu-xenial main' "\
"| sudo tee /etc/apt/sources.list.d/docker.list"
print_and_do "sudo apt-get update"
### installs required packages from list
inst_list=`cat VM_pkg_list`
print_and_do "sudo apt-get install -y linux-image-extra-$(uname -r) ${inst_list}"
print_and_do "sudo gpasswd -a ${USER} docker" # FIXME useless
print_and_do "sudo service docker start"

### set fish as the default shell
sudo chsh -s /usr/bin/fish ${username}
sudo chsh -s /usr/bin/fish # also for root user
### Get the DOCKER images
echo -e ${L_CYAN}"Getting docker images ..."${END_C}
print_and_do "docker pull $repo_name/$img_name"  && echo -e ${L_CYAN}"R3 image have been downloaded from dockerhub.
"${L_YELL}"You can also customize it and build it from ${BOLD}./r3/"${END_C}
###
#  DONE
###
# echo -e ${BOLD}"N.B. before starting Breeze :"${END_C}
# echo -e " _ Copy req. secrets to ${BOLD}${breeze_secrets_folder}${END_C} or use ./init_secret.sh (TODO automatize)"
# echo -e " _ Add the SSL certificates to ${BOLD}${nginx_folder}${END_C}"
# echo -e " _ Add the following SSH key to GitHub to be able to download R sources then run ${BOLD}./load_r_code.sh${END_C}"
# echo -e " _ if you'd like to restore any data into MySql, just store SQL query into ${BOLD}restore.sql${END_C} and they will be executed right after DB init"
# echo -e " _ if using Breeze-DB you need to copy appropriated files to ${BOLD}${breezedb_folder}${END_C}, and run"\
# " ${BOLD}${breezedb_cont_name}${END_C} container ${BOLD}before${END_C} running Breeze"
# echo -e ${BOLD_GREEN}"To start breeze, run './start_all.sh'"${END_C}
echo -e ${GREEN}"DONE"${END_C}
fish
