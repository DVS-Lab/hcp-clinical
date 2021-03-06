#!/bin/bash

basedir=`pwd`
MAINDATADIR=/data/projects/ppi-effect-sizes/data
MAINOUTPUTDIR=/data/projects/ppi-effect-sizes/fsl


#testing
task=$1
run=$2
subj=$3

datadir=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}
OUTPUTDIR=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}

mkdir -p $OUTPUTDIR
OUTPUT=${OUTPUTDIR}/smoothing

#check output
aromaoutput=${OUTPUT}.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
if [ -e $aromaoutput ]; then
	exit
else
	echo "re-running $subj on $task and run $run"
	rm -rf ${OUTPUT}.feat
fi

DATA=${datadir}/tfMRI_${task}_${run}.nii.gz
NVOLUMES=`fslnvols ${DATA}`

#find and replace: run feat for smoothing
TEMPLATE=${basedir}/templates/prep_aroma.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
<$TEMPLATE> ${OUTPUTDIR}/prep_aroma.fsf

feat ${OUTPUTDIR}/prep_aroma.fsf

#create variables for ICA AROMA and run it
myinput=${OUTPUT}.feat/filtered_func_data.nii.gz
myoutput=${OUTPUT}.feat/ICA_AROMA
mcfile=${OUTPUTDIR}/motion_6col.txt
rawmotion=${datadir}/Movement_Regressors.txt

#deleting any preexisting files
rm -rf $myoutput
python /data/projects/ppi-effect-sizes/splitmotion.py $rawmotion $mcfile

#run bet to create mask instead of using default feat output
inputmask=${OUTPUT}.feat/mean_func.nii.gz
aromamask=${OUTPUT}.feat/betmask
bet $inputmask $aromamask -f 0.3 -n -m -R

#running AROMA
python /data/projects/ppi-effect-sizes/ICA-AROMA-master/ICA_AROMA_Nonormalizing.py -in $myinput -out $myoutput -mc $mcfile -m ${aromamask}_mask.nii.gz
