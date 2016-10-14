#!/bin/bash
#

# setenv SUBJECTS_DIR /imaging/at03/NKG_Data_Sets/DATASET_1-01_visual-only/mne_subjects_dir/
# mne_setup_2.7.3_64bit
# setenv PATH /home/at03/MNE-2.7.4/bin:$PATH

SUBJECTS_DIR='/imaging/at03/NKG_Data_Sets/VerbphraseMEG/nme_subject_dir/'    # root directory for MRI data

subjects=(\
	'0003' 
	'0006' 
	'0007' 
	'0009' 
	'0011' 
	'0013' 
	'0019' 
	'0020' 
	'0021' 
	'0022' 
	'0028' 
	'0039' 
	'0040' 
	'0041' 
	'0043' 
	'0045' 
	'0061' 
	'0063' 
	'0073' 
	'0075' 
)

nsubjects=${#subjects[*]}
lastsubj=`expr $nsubjects - 1`


for m in `seq 0 ${lastsubj}`
do
        # creates surfaces necessary for BEM head models
        #mne_watershed_bem --overwrite --subject ${subjects[m]}
        #ln -s $SUBJECTS_DIR/${subjects[m]}/bem/watershed/${subjects[m]}'_inner_skull_surface' $SUBJECTS_DIR/${subjects[m]}/bem/inner_skull.surf
        #ln -s $SUBJECTS_DIR/${subjects[m]}/bem/watershed/${subjects[m]}'_outer_skull_surface' $SUBJECTS_DIR/${subjects[m]}/bem/outer_skull.surf
        #ln -s $SUBJECTS_DIR/${subjects[m]}/bem/watershed/${subjects[m]}'_outer_skin_surface'  $SUBJECTS_DIR/${subjects[m]}/bem/outer_skin.surf
        #ln -s $SUBJECTS_DIR/${subjects[m]}/bem/watershed/${subjects[m]}'_brain_surface'       $SUBJECTS_DIR/${subjects[m]}/bem/brain_surface.surf
        # creates fiff-files for MNE describing MRI data
        #mne_setup_mri --overwrite --subject ${subjects[m]}
        # create a source space from the cortical surface created in Freesurfer
        mne_setup_source_space --ico 5 --overwrite --subject ${subjects[m]} --cps
done
