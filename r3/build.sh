#!/bin/bash
# does the build, increment the version number and rotate old latest version
source common.sh

((version++))

folders=`find . -mindepth 1 -maxdepth 1 -type d  \( ! -iname ".*" \) | sed 's|^\./||g'`
folders_num=`echo "$folders" | wc -l`
i=0

for f in $folders
do
	((++i))
	echo "$i) $f"
done

# if there is more than one build source folder
if [ "$folders_num" -ge "2" ]; then
	echo -e "$BOLD$build_source$END_C is the current build source folder"
	# ask which source should we build from
	echo "Change build source folder to (press enter for no change):"
	# select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
	select d in */; 
	do
		if test -n "$d"; then
			echo "non empty"
			break;
		else
			echo "empty"
		fi
		echo ">>> Invalid Selection";
	done

	if [[ -z "$d" ]]; then
		break;
	fi

	d=$(echo $d | sed 's:/*$::')
	echo "You chose choice: "$d
	# change the build source
	build_source=$d
	# should we make it default
	read -p "Would you like to make this the default in build_conf.sh (y/N) ? " -n 1 -re
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		# writes the new default
		echo "build_source=$d # changed "`date --rfc-3339=second`>>build_conf.sh
	fi
fi
exit

docker build -t $repo_name/$img_name $build_source/
echo ${version}>.version
docker tag $repo_name/$img_name $img_full_name
docker images $repo_name/$img_name

