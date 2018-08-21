#!/bin/bash


for task in WM SOCIAL EMOTION GAMBLING; do
  for subj in `cat newsubs`; do
  	for RUN in LR RL; do

  		#Manages the number of jobs and cores
  		SCRIPTNAME=runAROMA.sh
  		NCORES=24
  		while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
  	  		sleep 1m
  		done
  		bash runAROMA.sh $task $RUN $subj &
  		sleep 5s

  	done
  done
done
