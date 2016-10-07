#!/bin/bash
# does the build, increment the version number and rotate old latest version
# ask for build folder source, checking each folder for Dockerfile
# if $build_source is changed, ask if user want to make it new default
# displays current $build_source
# displays FROM field from $build_source\Dockerfile
source common.sh

((version++))

# subfolder list and count
folders=`find . -mindepth 1 -maxdepth 1 -type d  \( ! -iname ".*" \) | sed 's|^\./||g'`
folders_num=`echo "$folders" | wc -l`

# check if current build source exists as a folder
if [ -d "$build_source" ]; then
	# checks for a Dockerfile
	f_path="$build_source/Dockerfile"
	if [ ! -e "$f_path" ]; then
		echo -e "$BOLD$build_source$END_C is the current build source, but "$RED"there is no Dockerfile in that folder$END_C !"
		build_source=""
	fi
else
	echo -e "$BOLD$build_source$END_C is the current build source, but "$RED"there is no such folder$END_C !"
	build_source=""
fi

d=$build_source # default

# count valid source folders
i=0
OIFS=$IFS
IFS=$'\n'
folders_list=""
for f in $folders
do
	# checks for a Dockerfile
	f_path="$f/Dockerfile"
	if [ -e "$f_path" ]; then
		folders_list=$folders_list"$f/"
		((++i))
	fi
	valid_folders_num=$i
done
IFS=$OIFS	

# echo "$valid_folders_num valid source folders"

# if there is more than 1 valid sub-folders
if [ "$valid_folders_num" -ge "2" ]; then
	echo -e "$BOLD$build_source$END_C is the current build source folder"
	while true
	do
		# displays a list of available build source folder (has to contain Dockerfile)
		echo -e $L_CYAN"Available build source folders:"$END_C
		j=0
		OIFS=$IFS
		IFS="/"
		for f in $folders_list
		do
			((++j))
			# numbered list of build source folders
			echo -e $BOLD"$j$END_C) $f"
		done
		if [[ -z "$d" ]]; then
			ask_text="Select source to build from ? [choose 1 to $j]"
		else
			ask_text="Change to ? [choose 1 to $j] (press enter for no change)"
		fi
		echo -n $ask_text": "
		read num
		if [ "$num" -ge "1" -a "$num" -le "$j" ] 2>/dev/null; then
			# changed to a valid selection, stores the new folder in $d
			# d=`printf "$folders_list" | sed ${num}'q;d'`
			d=`printf "$folders_list" | cut -d "/" -f $num`
			break;
		elif [[ -z "$num" && ! -z "$d" ]]; then
			# no change, uses $d default
			break;
		else
			echo -e $RED"Not a valid choice"$END_C
		fi
		IFS=$OIFS	
	done
elif [ "$valid_folders_num" -ge "1" ]; then
	d="${folders_list/"/"/''}"
else
	echo -e $RED"ERROR:$END_C there is no valid source folder to build from !\nCannot continue."
	exit
fi

function write_new_default(){
	# writes the new default into build_conf.sh (incremental write, do not overwrite the whole file)
	echo "build_source=\"$1\" # changed "`date --rfc-3339=second`>>build_conf.sh
	echo -e $L_CYAN"Updated default build source folder"$ENC_C
}

# if the build source has changed
if [ "$d" != "$build_source" ]; then
	# change the build source var
	echo -e "build source changed to $BOLD"$d$END_C
	# ask if to set this as the new default, provided the current default is not empty and there is more than one to choose from
	if [ "$valid_folders_num" -ge "2" -a ! -z "$build_source" ]; then
		# ask if we should make it default
		read -p "Set this as default (y/N) ? " -n 1 -re
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			write_new_default "$d"
		fi
	# otherwise set it as default anyway
	else
		write_new_default "$d"
	fi
	build_source=$d
fi

# display current build source folder
echo -e $GREEN"$BOLD$build_source$END_C$GREEN is the build source folder"$END_C
# get the FROM field from Dockerfile
dock_from=`cat $build_source/Dockerfile |grep FROM`
dock_from=${dock_from/"FROM "/""}
# display it
echo -e "Source in Dockerfile is: $L_CYAN$BOLD$dock_from$END_C"

# build and writes incremented build version on success
docker build -t $repo_name/$img_name $build_source/ && echo ${version}>.version && \
	docker tag $repo_name/$img_name $img_full_name
docker images $repo_name/$img_name

