#!/bin/bash


for task in Emo; do
  for subj in `cat sublist120.txt`; do
  	for run in LR RL; do
		for seed in Amyg; do

  		#Manages the number of jobs and cores
  		SCRIPTNAME=L1_${task}_PPI.sh
  		NCORES=14
  		while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
  	  		sleep 1m
  		done
  		bash $SCRIPTNAME $run $subj $seed &
  		sleep 5s

  	done
  done
done
done
