#!/bin/bash


for task in Gam; do
for seed in rAmyg; do
  for subj in `cat Michelle_AllSubs_n146.txt`; do

    #Manages the number of jobs and cores
    SCRIPTNAME=L2_${task}_PPI.sh
    NCORES=6
    while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
      sleep 1m
    done
    bash $SCRIPTNAME $subj $seed &
    sleep 5s

  done
done
done


