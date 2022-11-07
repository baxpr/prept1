#!/usr/bin/env bash
#
# Pipeline entrypoint for 7T hi-res T1 registration and scaling

# Initialize defaults for any input parameters where that seems useful
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
            ;;
        *) echo "Input ${1} not recognized"; shift ;;
    esac
done

echo "PD $pd_niigz"
echo "T1s ${t1_list[@]}"
echo "T1s ${#t1_list[@]}"
