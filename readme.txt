This new version of BEN calculation code can directly read .nii or .nii.gz file. To use it you can follow the matlab code batch_calc_uBEN.m  or through the following python code

# ofile defines the prefix of the output entropy map
# -d specifies the window length
# -r cutoff. r can be set to be from 0.1 - 0.6. For long time series, a lower r can be used.
# -num_dummies specifies how many dummy points will be removed from the beginning of the rsfMRI data
# -m brainmask. Brain mask used for removing background voxels. This mask should have the same spatial size as that of the rsfMRI data.
# -i input image
# -o output file. The filename will be patched to record some parameters.
# To run the code in windows, change "ben" below to be "benwin.exe".
# To run the code in Linux, change "ben" to be "ben_linux" in the following lines.
# 
# Python code for calling the code
cmdstr="ben" + " -d 3 -r 0.6 -c 30 -num_dummies 4 -m "+brainmask+ " -i  "+inputimg+" -o "+ofile
os.system(cmdstr)

# bash command line for calling the code in Linux
ben_linux -d 3 -r 0.6 -num_dummies 4 -c 30 -m brainmask.nii.gz -i inputimage.nii.gz -o entropyfilename
# bash command line for calling the code in Mac
ben_linux -d 3 -r 0.6 -num_dummies 4 -c 30 -m brainmask.nii.gz -i inputimage.nii.gz -o entropyfilename
# command line for calling the code in windows
benwin.exe -d 3 -r 0.6 -num_dummies 4 -c 30 -m brainmask.nii.gz -i inputimage.nii.gz -o entropyfilename


