#!/usr/bin/env bash

mkdir str_masks
cd str_masks

a=${FSLDIR}/data/atlases/Striatum/striatum-con-label-thr50-7sub-2mm

fslmaths $a -thr 1 -uthr 1 -bin str_limbic
fslmaths $a -thr 2 -uthr 2 -bin str_executive
fslmaths $a -thr 3 -uthr 3 -bin str_motor-r
fslmaths $a -thr 4 -uthr 4 -bin str_motor-c
fslmaths $a -thr 5 -uthr 5 -bin str_parietal
fslmaths $a -thr 6 -uthr 6 -bin str_occipital
fslmaths $a -thr 7 -uthr 7 -bin str_temporal

#<label index="0" x="107" y="138" z="64">limbic</label>
#<label index="1" x="114" y="138" z="73">executive</label>
#<label index="2" x="63" y="124" z="82">rostral-Motor</label>
#<label index="3" x="63" y="119" z="82">caudal-Motor</label>
#<label index="4" x="61" y="112" z="77">parietal</label>
#<label index="5" x="60" y="112" z="66">occipital</label>
#<label index="6" x="86" y="131" z="67">temporal</label>
