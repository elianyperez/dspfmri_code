#!/bin/bash
#SBATCH --account=stevenweisberg
#SBATCH --qos=stevenweisberg
#SBATCH --job-name=first_level
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=elianyperez@ufl.edu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=16gb
#SBATCH --time=24:00:00
#SBATCH --output=%x_%j.out
#pwd; hostname; date

# EP 4/25/2022

# Generate the subject list to make modifying this script
module load fsl/6.0.5

cd /blue/stevenweisberg/elianyperez/logs

#subjects= 'dspfmri11002' 'dspfmri11004' 'dspfmri11005' 'dspfmri11006' 'dspfmri11008' 'dspfmri11009' 'dspfmri11010' 'dspfmri11011' 'dspfmri11012' 'dspfmri12002' 'dspfmri12003' 'dspfmri12005' 'dspfmri12006' 'dspfmri12008' 'dspfmri12009' 'dspfmri12011' 'dspfmri12012' 'dspfmri12013' 'dspfmri12014' 'dspfmri21002' 'dspfmri21003' 'dspfmri22003' 'dspfmri22004' 'dspfmri22005' 'dspfmri22006' 'dspfmri22007'

subjects=('dspfmri11002' 'dspfmri11004' 'dspfmri11005' 'dspfmri11006' 'dspfmri11008' 'dspfmri11009' 'dspfmri11010' 'dspfmri11011' 'dspfmri11012' 'dspfmri12002' 'dspfmri12003' 'dspfmri12005' 'dspfmri12006' 'dspfmri12008' 'dspfmri12009' 'dspfmri12011' 'dspfmri12012' 'dspfmri12013' 'dspfmri12014')

for subj in "${subjects[@]}"  
do
    echo "===> Starting processing of $subj"
    echo
    
        
   #     # If the brain mask doesn’t exist, create it
    #    if [ ! -f anat/${subj}_T1w_brain_f02.nii.gz ]; then
      
   #    echo "Skull-stripped brain not found, using bet with a fractional intensity threshold of 0.2"
            # Note: This fractional intensity appears to work well for most of the subjects in the
    #        cp -R /blue/stevenweisberg/share/DSP_fMRI/sub-${subj}/anat/sub-${subj}_T1w.nii.gz
     #       bet2 /blue/stevenweisberg/share/DSP_fMRI/derivatives/sub-${subj}/anat/sub-${subj}_desc-preproc_T1w \
      #          /blue/stevenweisberg/elianyperez/DSP_fMRI/analysis/derivatives/clean_data/sub-${subj}/sub-${subj}_T1w_brain_f02_2.nii.gz -f 0.2
      
      #  fi

cd /blue/stevenweisberg/elianyperez/DSP_fMRI/analysis/derivatives/clean_data/

        # Copy the design files into the subject directory, and then
        # change “sub-08” to the current subject number
        cp design_run1.fsf /blue/stevenweisberg/elianyperez/DSP_fMRI/analysis/derivatives/clean_data/sub-${subj}
        cp design_run2.fsf /blue/stevenweisberg/elianyperez/DSP_fMRI/analysis/derivatives/clean_data/sub-${subj}
        cp design_run3.fsf /blue/stevenweisberg/elianyperez/DSP_fMRI/analysis/derivatives/clean_data/sub-${subj}
        cp design_run4.fsf /blue/stevenweisberg/elianyperez/DSP_fMRI/analysis/derivatives/clean_data/sub-${subj}
        
cd /blue/stevenweisberg/elianyperez/DSP_fMRI/analysis/derivatives/clean_data/sub-${subj}
        # Note that we are using the | character to delimit the patterns
        # instead of the usual / character because there are / characters
        # in the pattern.

       sed -i "s|dspfmri11002|${subj}|g" \
            design_run1.fsf
        sed -i "s|dspfmri11002|${subj}|g" \
            design_run2.fsf
        sed -i "s|dspfmri11002|${subj}|g" \
            design_run3.fsf
        sed -i "s|dspfmri11002|${subj}|g" \
            design_run4.fsf



        # Now everything is set up to run feat
       echo "===> Starting feat for run 1"
        feat design_run1.fsf
        echo "===> Starting feat for run 2"
        feat design_run2.fsf
        echo "===> Starting feat for run 3"
        feat design_run3.fsf
        echo "===> Starting feat for run 4"
        feat design_run4.fsf
        echo

    # Go back to the directory containing all of the subjects, and repeat the loop
    cd ..
done

echo