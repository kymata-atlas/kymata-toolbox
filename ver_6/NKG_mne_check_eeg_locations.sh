#!/bin/bash
#

################
# PARAMETERS:

# Input/Output file path:

path='/imaging/at03/NKG_Data_Sets/DATASET_3-01_visual-and-auditory'

# Input/Output file stems:

parts=(\
 'part1' 
 'part2' 
 )

subjects=(\
	'0045'
	'0051'
	'0054'
	'0055'
	'0056'
	'0058'
	'0060'
	'0065'
	'0066'
	'0068'
	'0070'
	'0071'
	'0072'
	'0079'
	'0081'
	'0082'
	'0086'
)

#####################
# SCRIPT BEGINS HERE:

nfiles=${#parts[*]}
lastfile=`expr $nfiles - 1`

nsubjects=${#subjects[*]}
lastsubj=`expr $nsubjects - 1`

# REPORT number of files to be processed:

for m in `seq 0 ${lastsubj}`
do

  echo " "
  echo "SUBJECT  ${subject_list[m]}: "

  for n in `seq 0 ${lastfile}`
  do
     

     echo " "
     echo " checking EEG channels for files nkg_${parts[n]}_raw.fif..."
     echo " "

     mne_check_eeg_locations --file ${path}/meg15_${subjects[m]}/nkg_${parts[n]}_raw.fif --fix

	
  done # file loop
	
done # subject loop

echo " "
echo "DONE"
echo " "

# END OF SCRIPT
######################


