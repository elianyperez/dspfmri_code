#!/bin/bash
#1=dcm2bids; 2=pydeface; 3=MRIQC; 4= fMRIprep

cd /blue/stevenweisberg/share/DSP_fMRI/code/logs
# for more than one subject:
# subjects=('dspfmri12003' 'dspfmri11002')

subjects=('dspfmri12013')

for subID in "${subjects[@]}"
do
  bash /blue/stevenweisberg/share/DSP_fMRI/code/DSP_fMRI_preprocessing_pipeline.sh $subID 4
done
