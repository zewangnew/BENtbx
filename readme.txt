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
# the ev file should contain two columns: onset and duration. For each row, onset+duration should be smaller than next onset.

ben_fmri -d 3 -r 0.6 -c 30 -m brainmask.nii.gz -ev evfile -i inputimage.nii.gz -o entropyfilename.nii.gz
# VERY IMPORTANT: if onsets and durations are recorded in a unit of seconds, you must provide TR in the command line, and the full command line will like:
ben_fmri -d 3 -r 0.6 -c 30 -TR 2 -m brainmask.nii.gz -ev evfile -i inputimage.nii.gz -o entropyfilename.nii.gz

instructions for using docker to run entropy calculation:
Instructions for running BENtbx using docker
Assuming data is saved in /home/yourname/workshop; data file is called sub_002_task.nii.gz. Using the following parameters: embedding window length w=3, cutoff threshold r=0.6 and output image name: bensub2.nii.gz, you can type the following command in linux or mac terminal to get the output. Output will be saved in /home/yourname/workshop/output

sudo docker run -it --rm -v $HOME/workshop:/data:ro -v $HOME/workshop/output:/out ben_docker:1 /code/ben -d 3 -r 0.6 -i /data/sub_002_task.nii.gz -m /data/imgmask.nii.gz -o /out/bensub2.nii.gz

-it means interactive: you will see intermediate prompt message
$HOME means /home/yourusername (yourusername will be automatically replaced by the real user name)
-v is to link a folder to one inside the container. -v $HOME/workshop:/data:ro means mounting the folder "workshop" in your
home directory to the path /data inside the container.
ro means read only
ben_docker is the name of the packaged container (similar to a virtual machine). :1 means the version. Currently, there is only one version.
-m /data/imgmask.nii.gz will take the mask image saved in /data/imgmask.nii.gz to remove outside brain voxels
sudo docker run -it --rm -v $HOME/workshop:/data:ro -v $HOME/workshop/output:/out ben_docker:1 /code/ben_seg -d 3 -r 0.6 -i /data/sub_002_task.nii.gz -ev fmriev.txt -m /data/imgmask.nii.gz -o /out/bensub2.nii.gz

-it means interactive: you will see intermediate prompt message
$HOME means /home/yourusername (yourusername will be automatically replaced by the real user name)
-v is to link a folder to one inside the container. -v $HOME/workshop:/data:ro means mounting the folder "workshop" in your
home directory to the path /data inside the container.
ro means read only
ben_docker is the name of the packaged container (similar to a virtual machine). :1 means the version. Currently, there is only one version.
-m /data/imgmask.nii.gz will take the mask image saved in /data/imgmask.nii.gz to remove outside brain voxels
-ev fmriev.txt will force the program to include the timepoints recorded in the text file: fmriev.txt only. Change fmriev.txt to your own evfile.
the ev file should contain two columns: onset and duration. For each row, onset+duration should be smaller than next onset.
VERY IMPORTANT: if onsets and durations are recorded in a unit of seconds, you must provide TR in the command line, and the full command line will like:
#sudo docker run -it --rm -v $HOME/workshop:/data:ro -v $HOME/workshop/output:/out ben_docker:1 /code/ben_seg -d 3 -r 0.6 -TR 1.2 -i /data/sub_002_task.nii.gz -ev fmriev.txt -m /data/imgmask.nii.gz -o /out/bensub2.nii.gz

-TR 1.2 means TR=1.2 sec.
