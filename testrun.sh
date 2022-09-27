#!/usr/bin/env bash

docker run \
    --mount type=bind,src=freesurfer_license.txt,dst=/usr/local/freesurfer/license.txt \
    --mount type=bind,src=`pwd -P`/INPUTS,dst=/INPUTS \
    --mount type=bind,src=`pwd -P`/OUTPUTS,dst=/OUTPUTS \
    -e DISPLAY=host.docker.internal:0 \
    baxterprogers/freesurfer720:v2.0.0 \
    --t1_niigz /OUTPUTS/mrmprage.nii.gz \
    --out_dir /OUTPUTS
