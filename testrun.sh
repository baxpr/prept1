#!/usr/bin/env bash

docker run \
    --mount type=bind,src=`pwd -P`/freesurfer_license.txt,dst=/usr/local/freesurfer/license.txt \
    --mount type=bind,src=`pwd -P`/INPUTS,dst=/INPUTS \
    --mount type=bind,src=`pwd -P`/OUTPUTS,dst=/OUTPUTS \
    -e DISPLAY=host.docker.internal:0 \
    baxterprogers/freesurfer720:v2.0.0 \
    --t1_niigz /OUTPUTS/smrmprage.nii.gz \
    --out_dir /OUTPUTS2



docker run -it \
    --mount type=bind,src=`pwd -P`/freesurfer_license.txt,dst=/usr/local/freesurfer/license.txt \
    --mount type=bind,src=`pwd -P`/INPUTS,dst=/INPUTS \
    --mount type=bind,src=`pwd -P`/OUTPUTS,dst=/OUTPUTS \
    -e DISPLAY=host.docker.internal:0 \
    --entrypoint bash \
    baxterprogers/freesurfer720:v2.0.0

#    recon-all -watershed atlas -autorecon1 -sd /OUTPUTS -s MRMPRAGE -i /OUTPUTS/mrmprage.nii.gz
#    recon-all -watershed atlas -autorecon1 -sd /OUTPUTS -s SMRMPRAGE -i /OUTPUTS/smrmprage.nii.gz
