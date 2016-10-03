#!/bin/bash
# This script is called upon container start.
# Place here any configuration required and call to the next script which should trigger the job.
# The data folder is mounter under /breeze
export DOCK_HOME=$DOCK_HOME
export HOME=$DOCK_HOME
cd $DOCK_HOME/projects/breeze-dev/db/reports/3628_validation_small_jmpindi
./sgeconfig.sh
