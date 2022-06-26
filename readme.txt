This new version of BEN calculation code can directly read .nii or .nii.gz file. To use it you can follow the matlab code batch_calc_uBEN.m  or through the following python code

# ofile defines the prefix of the output entropy map
# -d specifies the window length
# -r cutoff. r can be set to be from 0.1 - 0.6. For long time series, a lower r can be used.
# -num_dummies specifies how many dummy points will be removed from the beginning of the rsfMRI data
# -m brainmask. Brain mask used for removing background voxels. This mask should have the same spatial size as that of the rsfMRI data.
# -c  number of CPU cores to be used.
# -i input image
# -o output file. The filename will be patched to record some parameters.

# Python code for calling the code
cmdstr=ben + " -d 3 -r 0.6 -c 30 -m "+brainmask+ " -i  "+inputimg+" -o "+ofile
os.system(cmdstr)

# bash command line for calling the code
ben -d 3 -r 0.6 -c 30 -m brainmask.nii.gz -i inputimage.nii.gz -o entropyfilename.nii.gz

# If you want to calculate entropy for a continuous section of the entire time series, you can use num_dummies to define the starting point, and use tlen_2use 
# to define the end of the segment. In C, data index starts from 0, so the data segment will be from num_dummies to num_dummies+tlen_2use-1.
# An example is if your data has 100 timepoints, and you want to calculate entropy using data from the 20th to 29th time points (including 20th and 29th
# suppose that the first timepoint is time 1), you can specify
# -num_dummies 19 -tlen_2use 10
# the full command is:
# ben -d 3 -4 0.6 -c 30 -num_dummies 19 -tlen_2use 10 -m brainmask.nii.gz -i inputimage.nii.gz -o entropyfilename.nii.gz

# calculating BEN using part of the input images as specified by the ev file.
# In the evfile, each colume will correspond to one BEN map. 1's in the columen label the timepoints to be used.
ben_fmri -d 3 -r 0.6 -c 30 -m brainmask.nii.gz -ev evfile -i inputimage.nii.gz -o entropyfilename.nii.gz
