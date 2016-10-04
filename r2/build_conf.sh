rel_path=`dirname "${BASH_SOURCE}/"`/
repo_name=fimm
img_name=r2
tag=v
if [ ! -f $rel_path.version ];
then
	touch $rel_path.version
	echo 0>$rel_path.version
fi
version=$(<$rel_path.version)
img_full_name=$repo_name/$img_name:$tag$version



