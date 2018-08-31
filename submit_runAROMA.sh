#!/bin/bash


for task in WM SOCIAL EMOTION GAMBLING; do
  for subj in `cat all_new_subs.txt`; do
  	for RUN in LR RL; do

  		#Manages the number of jobs and cores
  		SCRIPTNAME=runAROMA.sh
  		NCORES=12
  		while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
  	  		sleep 1m
  		done
  		bash runAROMA.sh $task $RUN $subj &
  		sleep 5s

  	done
  done
done
