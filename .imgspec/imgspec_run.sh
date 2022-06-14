#!/bin/bash

sister_dir=$( cd "$(dirname "$0")" ; pwd -P )
grainsize_pge_dir=$(dirname ${sister_dir})

for a in `ls -1 input/*.tar.gz`; do tar -xzvf $a -C input; done

rfl_file=$(ls input/*/*rfl)
file_base=$(basename $rfl_file)

if [[ $file_base == f* ]]; then
    output_prefix=$(echo $file_base | cut -c1-16)
elif [[ $file_base == ang* ]]; then
    output_prefix=$(echo $file_base | cut -c1-18)
elif [[ $file_base == PRS* ]]; then
    output_prefix=$(echo $file_base | cut -c1-38)
elif [[ $file_base == DESIS* ]]; then
    output_prefix=$(echo $file_base | cut -c1-44)
fi

out_dir=${output_prefix}_grainsize
mkdir -p output/${out_dir}

# Run Grain Size PGE, export L2A_SI_TRAIT file
python ${grainsize_pge_dir}/grainsize.py $rfl_file output/${out_dir} --verbose

# gzip output files in preparation for downstream processing
cd out_dir
tar -czvf ${out_dir}.tar.gz ${out_dir}
rm -rf $out_dir
# gzip ${out_dir}.tar.gz
