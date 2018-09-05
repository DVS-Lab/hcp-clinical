#!/bin/bash

##bash L3_Gam_all.sh $TYPE $COPENUM
#make sure not use $C since L2 has this variable and may cause errors in pipeline
TYPE=$1
COPENUM=$2

basedir=`pwd`
MAINDATADIR=/data/projects/ppi-effect-sizes/data
MAINOUTPUTDIR=/data/projects/ppi-effect-sizes/fsl

#add _sad at the end of gfeat output for sad_dep
OUTPUT=${MAINOUTPUTDIR}/L3_${TYPE}_${COPENUM}

#check L3 output; avoid running analyses twice/overwriting
#remove sanity check when running full dataset
#SANITY CHECK WILL ONLY SHOW SCRIPT WORKS IF THE OUTPUT FOLDER DOES NOT ALREADY EXIST
if [ -e ${OUTPUT}.gfeat/cope1.feat/cluster_mask_zstat1.nii.gz ]; then
  echo "L3_Gam has been run for $TYPE $COPENUM"
  exit
else
  rm -rf ${OUTPUT}.gfeat
fi

##find and replace
#####old notes from L3 for NIH sadness#####
#input template L3Gamtest for plain activation
#input template L3Gamtest_sad for sad_dep
#add _sad at the end of fsf file for nih sadness score
#####old notes from L3 for NIH sadness#####
ITEMPLATE=${basedir}/templates/L3GamAct.fsf
OTEMPLATE=${MAINOUTPUTDIR}/L3_${TYPE}_${COPENUM}.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@TYPE@'$TYPE'@g' \
-e 's@COPENUM@'$COPENUM'@g' \
<$ITEMPLATE> $OTEMPLATE

#runs feat on output template
feat $OTEMPLATE

##start randomise
#cd ${OUTPUT}.gfeat/cope1.feat

##run randomise on orig data sans depression scores
#get tfce output OR
#get cluster-thresholded output at 3.1 threshold (add -c 3.1 after -T flag)
#add -D flag after permutation number to demean
#randomise -i filtered_func_data.nii.gz -o randomise -d design.mat -t design.con -m mask.nii.gz -n 10000 -T -c 3.1

