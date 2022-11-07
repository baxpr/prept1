#!/usr/bin/env bash
#
# Pipeline entrypoint for 7T hi-res T1 registration and scaling

# Initialize defaults for input parameters
export t1_niigzs=/INPUTS/t1.nii.gz
export pd_niigz=/INPUTS/pd.nii.gz
export out_dir=/OUTPUTS

# Parse input options. Bit of extra gymnastics to allow multiple files
# listed after --t1_niigzs - these are put into the array t1_list
t1_list=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in      
        --pd_niigz)        export pd_niigz="$2";        shift; shift ;;
        --out_dir)         export out_dir="$2";         shift; shift ;;
        --t1_niigzs)
            next="$2"
            while ! [[ "$next" =~ -.* ]] && [[ $# > 1 ]]; do
                t1_list+=("$next")
                shift
                next="$2"
            done
            shift ;;
        *) echo "Input ${1} not recognized"; shift ;;
    esac
done

num_t1=${#t1_list[@]}
echo "PD: $pd_niigz"
echo "T1s (${num_t1}): ${t1_list[@]}"

# Work in output dir
cd "${out_dir}"

# Copy files to outputs dir
cp "${pd_niigz}" ./pd.nii.gz
ctr=0
for t1 in ${t1_list[@]} ; do
    ctr=$(($ctr + 1))
    cp "$t1" ./t1_${ctr}.nii.gz
done

# Register all other T1s to the first
cp t1_1.nii.gz rt1_1.nii.gz
for n in $(seq 2 $num_t1) ; do
    echo Registering ${n} to 1
    flirt \
        -usesqform \
        -ref t1_1 \
        -in t1_${n} \
        -out rt1_${n}
done

# Compute mean T1
cmd="fslmaths t1_1"
for n in $(seq 2 $num_t1) ; do
    cmd+=" -add t1_${n}"
done
cmd+=" -div ${n} mrt1"
eval $cmd

# Register PD to the mean T1
flirt \
    -cost mutualinfo \
    -usesqform \
    -in pd \
    -ref mrt1 \
    -out rpd

# Smooth the PD
fslmaths rpd -s 10 srpd

# Scale the t1 by PDF
fslmaths mrt1 -div srpd smrt1

