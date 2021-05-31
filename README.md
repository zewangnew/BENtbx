# BENtbx
A new version of the entropy calculation code of the BENtbx
ben included here is compiled using gcc 5.4.  The Windows version was compiled with VS2012. To use the code, read the file readme.txt and follow the example provided there and in batch_calc_uBEN.m. You can still go to https://cfn.upenn.edu/zewang/BENtbx.php to download the sample data and matlab code. batch_calc_uBEN.m will read the code in par.m to find the data.
If you meet any problem (especially for Mac machine), please let me know.

The following is copied from readme.txt.

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
