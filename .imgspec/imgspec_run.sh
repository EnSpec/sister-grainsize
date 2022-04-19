#!/bin/bash

sister_dir=$( cd "$(dirname "$0")" ; pwd -P )
grainsize_pge_dir=$(dirname ${sister_dir})

out_dir='output'
rfl_file=input/PRS_20210302180507_20210302180511_0001_rfl_prj_rfl

mkdir -p $out_dir

# Run Grain Size PGE, export L2A_SI_TRAIT file
python ${grainsize_pge_dir}/grainsize.py $rfl_file $out_dir/ --verbose

# gzip output files in preparation for downstream processing
#cd $out_dir
tar -cf ${out_dir}.tar ${out_dir}
rm -rf $out_dir
gzip ${out_dir}.tar