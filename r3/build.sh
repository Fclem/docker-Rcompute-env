#!/bin/bash
# does the build, increment the version number and rotate old latest version
source common.sh

((version++))

folders=`find . -mindepth 1 -maxdepth 1 -type d  \( ! -iname ".*" \) | sed 's|^\./||g'`
folders_num=`echo "$folders" | wc -l`

# if there is more than one build source folder
if [ "$folders_num" -ge "2" ]; then
	echo -e "$BOLD$build_source$END_C is the current build source folder"
	# ask which source should we build from
	# select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
	while true
	do
		echo -e $L_CYAN"Available build source folders:"$END_C
		i=0
		OIFS=$IFS
		IFS=$'\n'
		folders_list=""
		for f in $folders
		do
			f_path="$f/Dockerfile"
			# echo $f_path
			if [ -e "$f_path" ]; then
				folders_list=$folders_list$f'\n'
				((++i))
				echo -e $BOLD"$i$END_C) $f"
			fi
		done
		# folders_list=$folders_list'\n'
		# echo
		# printf "$folders_list"
		# echo
		d=$build_source # default
		echo -n "Change to ? [choose 1 to $i] (press enter for no change) "
		read num
		if [ "$num" -ge "1" -a "$num" -le "$i" ] 2>/dev/null; then
			d=`printf "$folders_list" | sed ${num}'q;d'`
			# echo $folders[$num]
			break;
		elif [[ -z "$num" ]]; then
			# echo "no change"
			break;
		else
			echo -e $RED"Invalid choice"$END_C
		fi
		IFS=$OIFS	
	done

	# echo -e $GREEN"Target will be built from: $BOLD$d\Dockerfile"$END_C
	# if the build source has changed
	if [ "$d" != "$build_source" ]; then
		# change the build source var
		build_source=$d
		# ask if we should make it default
		read -p "Set this as default (y/N) ? " -n 1 -re
		if [[ $REPLY =~ ^[Yy]$ ]]
		then
			# writes the new default
			echo "build_source=\"$d\" # changed "`date --rfc-3339=second`>>build_conf.sh
		fi
	fi
#	FROM cbarraford/r3x:latest
fi

echo -e $GREEN"$BOLD$build_source$END_C$GREEN is the build source folder"$END_C
dock_from=`cat $build_source/Dockerfile |grep FROM`
dock_from=${dock_from/"FROM "/""}
echo -e "Source in Dockerfile is: $L_CYAN$BOLD$dock_from$END_C"

docker build -t $repo_name/$img_name $build_source/
echo ${version}>.version
docker tag $repo_name/$img_name $img_full_name
docker images $repo_name/$img_name

