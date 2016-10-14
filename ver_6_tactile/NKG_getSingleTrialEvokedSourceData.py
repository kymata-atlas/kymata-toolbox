#!/usr/bin/python

import sys
sys.path.append('/imaging/local/software/mne_python/latest_v0.8')
sys.path.append('/imaging/local/software/python_packages/scikit-learn/v0.14.1')
sys.path.append('/imaging/local/software/python_packages/pysurfer/v0.4')
import os
import pdb
import pylab as pl
import mne
import numpy as np
from mne import read_evokeds
from mne.minimum_norm import apply_inverse, read_inverse_operator


participants = [
        'meg15_0537_1',
	'meg15_0537_2' 
]

f = open('/imaging/at03/NKG_Data_Sets/DATASET_3-01_visual-and-auditory/items.txt', 'r')
words = list(f.read().split())

data_path = '/imaging/at03/NKG_Code_output/Version5/DATASET_3-02_tactile_toes/'
subjects_dir = '/imaging/at03/NKG_Data_Sets/DATASET_1-01_visual-only/mne_subjects_dir'

snr = 1
lambda2 = 1.0 / snr ** 2

for p in participants:

	# Make temporary STC to get it's vertices

	inverse_operator = read_inverse_operator((data_path + '3-sensor-data/inverse-operators/'  + p + '_ico-5-3L-loose02-diagnoise-nodepth-reg-inv-csd.fif'))
	if os.path.exists((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[0] + '.-avefif')) == True:
		evoked = read_evokeds((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[0] + '-ave.fif'), condition=0, baseline=None)
	elif os.path.exists((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[1] + '-ave.fif')) == True:
		evoked = read_evokeds((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[1] + '-ave.fif'), condition=0, baseline=None)
	elif os.path.exists((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[2] + '-ave.fif')) == True:
		evoked = read_evokeds((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[2] + '-ave.fif'), condition=0, baseline=None)
	elif os.path.exists((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[3] + '-ave.fif')) == True:
		evoked = read_evokeds((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[3] + '-ave.fif'), condition=0, baseline=None)
	elif os.path.exists((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[4] + '-ave.fif')) == True:
		evoked = read_evokeds((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[4] + '-ave.fif'), condition=0, baseline=None)
	else:
		evoked = read_evokeds((data_path + '3-sensor-data/fif-out/'  + p + '_' + words[5] + '-ave.fif'), condition=0, baseline=None)
	stc_from = apply_inverse(evoked, inverse_operator, lambda2, "MNE", pick_ori='normal') # don't matter what this is


	# First compute morph matices for participant	
	subject_to = 'fsaverage'
	subject_from = '0195'
	vertices_to = mne.grade_to_vertices(subject_to, grade=5, subjects_dir=subjects_dir) #grade 4 is 2562
	morph_mat = mne.compute_morph_matrix(subject_from, subject_to, stc_from.vertices, vertices_to, subjects_dir=subjects_dir)

	# Compute source stcs
	for w in words:
		# Apply Inverse
		evoked = read_evokeds((data_path + '3-sensor-data/fif-out/'  + p + '_' + w + '-ave.fif'), condition=0, baseline=None)

		if (evoked.nave > 0):
			stc_from = apply_inverse(evoked, inverse_operator, lambda2, "MNE", pick_ori='normal')

			# Morph to average
			stc_from.subject = subject_from # only needed if subject has been tested previously and so has a different subject number 
			stc_morphed = mne.morph_data_precomputed(subject_from, subject_to, stc_from, vertices_to, morph_mat)
			stc_morphed.save((data_path + '/4-single-trial-source-data/vert10242-nodepth-diagonly-snr1-signed-fsaverage-baselineNone/' + p + '-' + w))
	
