# BENtbx
A new version of the entropy calculation code of the BENtbx
ben included here is compiled using gcc 5.4.  The Windows version was compiled with VS2012. To use the code, read the file readme.txt and follow the example provided there and in batch_calc_uBEN.m. You can still go to https://cfn.upenn.edu/zewang/BENtbx.php to download the sample data and matlab code. batch_calc_uBEN.m will read the code in par.m to find the data.
If you meet any problem (especially for Mac machine), please let me know.
I have provided a docker container for calculating BEN. You can also provide an ev file to specify which timepoints should be included. This option is helpful for task fMRI if you want to calculate BEN for a specific condition only.

(In Chinese)
BENtbx 可以在Linux, Windows, 和MacOS 下运行，请选择对应的版本。输入图像必须是nii 或者nii.gz格式，如果你需要支持cifti格式请单独联系，相关程序还未正式发布。如果出现“segmentation fault"错误很可能是图像有问题，可以先检查一下是否能打开该图像文件，或者是输入参数有问题，比如d取的太大。另外输入的大脑模板(mask)必须跟输入图像的大小一致。下文提到的docker container可以在各大操作系统中运行，是跨平台数据处理的理想选择。container中的针对fMRI数据的BEN 计算程序在本目录中也可以找到。利用这个程序你可以指定计算哪些图像的熵。

The following is copied from readme.txt.

# ofile defines the prefix of the output entropy map
# -d specifies the window length
# -r cutoff. r can be set to be from 0.1 - 0.6. For long time series, a lower r can be used.
# -num_dummies specifies how many dummy points will be removed from the beginning of the rsfMRI data
# -m brainmask. Brain mask used for removing background voxels. This mask should have the same spatial size as that of the rsfMRI data.
# -i input image
# -c number of CPU cores to be used.
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

## instructions for using docker to run entropy calculation:
# Instructions for running BENtbx using docker.
You should first make sure your user ID is in the group "docker". You can simply type: sudo usermod -a -G docker $USER to add your ID to that group. Most of time, you will need to reboot the computer (you can try the following command first before reboot. If it doesn't work, then reboot).

Assuming data is saved in /home/yourname/workshop; data file is called sub_002_task.nii.gz. Using the following parameters: embedding window length w=3, cutoff threshold
r=0.6 and output image name: bensub2.nii.gz, you can type the following command in linux or mac terminal to get the output.  Output will be saved in /home/yourname/workshop/output

sudo docker run -it --rm -v $HOME/workshop:/data:ro -v $HOME/workshop/output:/out ben_docker:1 /code/ben -d 3 -r 0.6 -i /data/sub_002_task.nii.gz -m /data/imgmask.nii.gz -o /out/bensub2.nii.gz

## If the above command returned with error like "permission denied" etc. try the following:
sudo docker run -it --rm -v $HOME/workshop:/data:ro -v $HOME/workshop/output:/out redhatwdoc/ben_docker:1 /code/ben -d 3 -r 0.6 -i /data/sub_002_task.nii.gz -m /data/imgmask.nii.gz -o /out/bensub2.nii.gz


## -it means interactive: you will see intermediate prompt message
## $HOME means /home/yourusername (yourusername will be automatically replaced by the real user name)
## -v is to link a folder to one inside the container. -v $HOME/workshop:/data:ro means mounting the folder "workshop" in your
##  home directory to the path /data inside the container. 
##  ro means read only
##  ben_docker is the name of the packaged container (similar to a virtual machine). :1 means the version. Currently, there is only one version. 
##  -m /data/imgmask.nii.gz  will take the mask image saved in /data/imgmask.nii.gz to remove outside brain voxels



sudo docker run -it --rm -v $HOME/workshop:/data:ro -v $HOME/workshop/output:/out ben_docker:1 /code/ben_seg -d 3 -r 0.6 -i /data/sub_002_task.nii.gz -ev fmriev.txt -m /data/imgmask.nii.gz -o /out/bensub2.nii.gz

## -it means interactive: you will see intermediate prompt message
## $HOME means /home/yourusername (yourusername will be automatically replaced by the real user name)
## -v is to link a folder to one inside the container. -v $HOME/workshop:/data:ro means mounting the folder "workshop" in your
##  home directory to the path /data inside the container. 
##  ro means read only
##  ben_docker is the name of the packaged container (similar to a virtual machine). :1 means the version. Currently, there is only one version. 
##  -m /data/imgmask.nii.gz  will take the mask image saved in /data/imgmask.nii.gz to remove outside brain voxels
##  -ev fmriev.txt  will force the program to include the timepoints recorded in the text file: fmriev.txt only.  Change fmriev.txt to your own evfile.
##       the ev file should contain two columns: onset and duration.  For each row, onset+duration should be smaller than next onset.
##       VERY IMPORTANT: if onsets and durations are recorded in a unit of seconds, you must provide TR in the command line, and the full command line will like:
#sudo docker run -it --rm -v $HOME/workshop:/data:ro -v $HOME/workshop/output:/out ben_docker:1 /code/ben_seg -d 3 -r 0.6 -TR 1.2 -i /data/sub_002_task.nii.gz -ev fmriev.txt -m /data/imgmask.nii.gz -o /out/bensub2.nii.gz

# -TR 1.2 means TR=1.2 sec.


