# DLC
scripts for DeepLabCut

These scripts can be used to run DeepLabCut on Compute Canada's virtual cluster!

Unless you want to make your own modifications, ParallelDLC.sh is the only script you need to use/modify.<br>
Everything you need to modify in the script is clearly outlined in comments at the start of the script.

ParallelDLC.sh should be put inside the root directory from which you want to run multiple simultaneous deeplabcut sessions.

Inputs include:
- Your initials (what your animal ID starts with; e.g., ZHA001 starts with ZHA) and animal ID length (e.g., ZHA001 is 6 characters long)
- Your email, for job notifications
- Location of your DLC config file
- Location of your DLC_env virtual environment (see DLC_setup.sl)
- Minimum file size parameter (1M or 1 megabyte default)
- Minimum file count parameter (default 3)
- Location of root directory (default current working directory "pwd")
- Ability to choose concatenation of video or not (default "True")

This script works by:

1. Looking for all "BehavCam_0" folders in subdirectories within the specified root directory
2. copying the necessary slurm scripts, python scripts, (also renaming DUMMY VARIABLES (in caps) in the scripts) to run DLC
3. using sbatch to submit a job for each slurm script, which will be submitted inside the "BehavCam_0" folder for that session.

This script will not work if:
- You have too few video files (default < 3; can be changed)
- You have video files with an unusually small size (default < 1M; can be changed)
- You have already ran DLC (checks for "DLC" in the filenames in the BehavCam folders)
- You don't have either a concatenated avi file (*_concat.avi) or a 0.avi file
- You do not have a DLC_env virtual environment setup in your home directory

If you have concatenation set to True (by default) then...

DLC_concat_traces.sl will:

1. Check if videos have already been concatenated (looks for *_concat.avi); skips concatenation step if true
2. If not, makes a sorted list of all videos to concatenate
3. Counts the total number of frames in all these videos
4. Concatenates them into a new file named as "animalID_concat.avi"
5. Counts the number of frames in this new avi file and compares it to the total frame count of the originals
6. ONLY if the frame counts match, then, it will tar all the smaller avi files together
7. ONLY if tar was successful, then, it will delete all the smaller avi files
8. ONLY if all the above steps were successful, it will then load the DLC virtual environment and begin DLC video analysis on the single new avi file 

DLC_traces.py loads deeplabcut and runs the single function "deeplabcut.analyze_videos()" on the video data and config file specified in ParallelDLC.sh.<br>
It will output a single csv file, an h5 file, and a pickle file.<br>
It will also produce additional filtered traces csv file, and rename your csv files to something more logical based on directory path.<br>
If you do not want this, please edit your DLC_trace.py files as needed.

Concatenation step can be skipped in ParallelDLC.sh, and you can instead use DLC_traces.sl, which skips concatenations and just starts the DLC environment.<br> 
However, this is not recommended as you will create 3 output files for every recorded video file.<br> 
We have a file # limit to respect on the cluster! PLEASE make sure to clean up your files if you choose not to concatenate and tar your data automatically!

Concatenation step takes 1-3 minutes, depending on number of videos.<br>
Overall, scripts should run in ~30-50 minutes per 40 minutes of video recordings.<br>
If your job completes in less than 10 minutes, it's likely concatenation worked but DLC didn't run. Or you had very few videos (<5)<br>
NOTE: Scripts running on Narval GPUs are considerably faster! Can finish in less than 10 minutes for a 40 minute recording.<br>
This can make error detection (i.e., video not analyzed) more difficult to detect.


Enjoy! If you have any questions, contact me at z.haqqee@gmail.com

-- Zeeshan
