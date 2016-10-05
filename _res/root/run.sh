#!/bin/bash
# This script is called upon container start.
# Place here any configuration required and call to the next script which should trigger the job.
# The data folder is mounter under /breeze
export RES_FOLDER='/res'
export IN_FILE='in.tar.xz'			# file name to use for the input/job set archive
export OUT_FILE='out.tar.xz'			# file name to use fot the output/result archive
export OUT_FILE_PATH=$HOME'/'$OUT_FILE		# path to the final archive to be created
export NEXT_SH=$HOME'/run.sh' 			# path of the next file to run
export JOB_ID=$1 				# Job id designate the file to be downloaded from Azure-storage
export AZURE_STORAGE_FN='azure_storage.py'	# name of the azure-storage python file
export STORAGE_FN='blob_storage_module.py'
export AZURE_KEY_FN='azure_pwd_breezedata'	# TODO change the last word to the name of the azure-storage account you wish to use
export AZURE_PY=$RES_FOLDER'/'$AZURE_STORAGE_FN	# full path of the azure-storage python interface
RELEVANT_COMMIT='02646ed76e75a141d9ec671c68eab1a5439f48bb'
# Url of the initial sotrage-module and azure-storage files (the specified version must support 'upgrade' action)
AZURE_GIT_URL='https://raw.githubusercontent.com/findcomrade/isbio/'$RELEVANT_COMMIT'/isbio/breeze/'$AZURE_STORAGE_FN
STORAGE_GIT_URL='https://raw.githubusercontent.com/findcomrade/isbio/'$RELEVANT_COMMIT'/isbio/breeze/'$STORAGE_FN
END_C='\033[39m'
BLUE='\033[34m'
RED='\033[31m'
# empty the home folder (just in case) (and suppressing any error)
rm -fr $HOME/* > /dev/null 2>&1
# go to home folder (usually /root), this folder being non-persistant and container specific
echo -e $BLUE'cd '$RES_FOLDER''$END_C
cd $RES_FOLDER
# copy the Azure access key from the externaly mounted shared folder
echo -e $BLUE'cp '$DOCK_HOME'/'$AZURE_KEY_FN' '$RES_FOLDER'/'$END_C
cp $DOCK_HOME'/'$AZURE_KEY_FN $RES_FOLDER'/'
# if the azure-storage python file is non-existant
actualsize=$(wc -c <"$AZURE_STORAGE_FN") # get the size of the file, in case it is blank 
if [ -z $actualsize ] || [ $actualsize -le 7000 ];
then
	# download a possibly outdated version of azure-sotrage python file
	echo -e $BLUE'getting '$STORAGE_FN' from github...'$END_C
        wget --backups=1 $STORAGE_GIT_URL
	echo -e $BLUE'getting '$AZURE_STORAGE_FN' from github...'$END_C
	wget --backups=1 $AZURE_GIT_URL
fi
# grants exec privilege
chmod go-rwx $AZURE_STORAGE_FN
chmod u+wx $AZURE_STORAGE_FN
# trigger self-update of the azure-sotrage python file (from Azure)
echo -e $BLUE'updating '$AZURE_STORAGE_FN''$END_C
./$AZURE_STORAGE_FN upgrade
# grants exec privilege
chmod go-rwx $AZURE_STORAGE_FN
chmod u+x $AZURE_STORAGE_FN
# get the job archive from Azure storage
echo -e $BLUE'getting job '$JOB_ID''$END_C
./$AZURE_STORAGE_FN load $JOB_ID
EX=$?
# if succcessful, extract and run
if [ $EX -eq 0 ];
then
	echo -e $BLUE'cd '$HOME''$END_C
	cd $HOME
	# extract the archive
	echo -e $BLUE'extracting '$IN_FILE' to '$HOME''$END_C
	tar xvf $IN_FILE -C $HOME/
	chmod ug+rx $NEXT_SH
	# run (usually the next file will be a bootstrap to manage the execution of the job)
	echo -e $BLUE'running '$NEXT_SH''$END_C
	$NEXT_SH
	EX=$?
else
	echo -e $RED$AZURE_STORAGE_FN' failure (code '$EX') !'$END_C
fi
exit $EX

