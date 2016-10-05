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

# if there is more than one subfolder
if [ "$folders_num" -ge "2" ]; then
	echo -e "$BOLD$build_source$END_C is the current build source folder"
	while true
	do
		# displays a list of available build source folder (has to contain Dockerfile)
		echo -e $L_CYAN"Available build source folders:"$END_C
		i=0
		OIFS=$IFS
		IFS=$'\n'
		folders_list=""
		for f in $folders
		do
			# checks for a Dockerfile
			f_path="$f/Dockerfile"
			if [ -e "$f_path" ]; then
				folders_list=$folders_list$f'\n'
				((++i))
				# numbered list of build source folders
				echo -e $BOLD"$i$END_C) $f"
			fi
		done
		d=$build_source # default
		echo -n "Change to ? [choose 1 to $i] (press enter for no change) "
		read num
		if [ "$num" -ge "1" -a "$num" -le "$i" ] 2>/dev/null; then
			# changed to a valid selection, stores the new folder in $d
			d=`printf "$folders_list" | sed ${num}'q;d'`
			break;
		elif [[ -z "$num" ]]; then
			# no change, uses $d default
			break;
		else
			echo -e $RED"Invalid choice"$END_C
		fi
		IFS=$OIFS	
	done

	# if the build source has changed
	if [ "$d" != "$build_source" ]; then
		# change the build source var
		build_source=$d
		# ask if we should make it default
		read -p "Set this as default (y/N) ? " -n 1 -re
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			# writes the new default into build_conf.sh (incremental write, do not overwrite the whole file)
			echo "build_source=\"$d\" # changed "`date --rfc-3339=second`>>build_conf.sh
		fi
	fi
fi

# display current build source folder
echo -e $GREEN"$BOLD$build_source$END_C$GREEN is the build source folder"$END_C
# get the FROM field from Dockerfile
dock_from=`cat $build_source/Dockerfile |grep FROM`
dock_from=${dock_from/"FROM "/""}
# display it
echo -e "Source in Dockerfile is: $L_CYAN$BOLD$dock_from$END_C"

# build and writes incremented build version on success
docker build -t $repo_name/$img_name $build_source/ && echo ${version}>.version
docker tag $repo_name/$img_name $img_full_name
docker images $repo_name/$img_name

