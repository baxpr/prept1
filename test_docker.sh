#!/usr/bin/env bash

docker run \
    --mount type=bind,src=`pwd -P`/INPUTS,dst=/INPUTS \
    --mount type=bind,src=`pwd -P`/OUTPUTS,dst=/OUTPUTS \
    prept1:test \
    --pd_niigz /INPUTS/pd.nii.gz \
    --t1_niigzs /INPUTS/mprage1.nii.gz /INPUTS/mprage2.nii.gz /INPUTS/mprage3.nii.gz \
    --fwhm 10 \
    --out_dir /OUTPUTS

