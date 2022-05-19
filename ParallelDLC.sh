#!/bin/bash

########################################################################################

### Enter your 3-letter initials below; this is used to name jobs based on Animal ID
### Note that this and the email input are both OPTIONAL! If you put nothing, or put something incorrect, the script will likely still launch your jobs.
###### Except that the job names might look strange and you won't get e-mail notifications

# for example, the animal "ZHA001" has initials "ZHA" and IDlength 6
initials="ZHA"
IDlength=6

### Enter your e-mail below
email="computezee@gmail.com"

### Enter the full parent directory for analysis in the () brackets (default is pwd)
### The script will search from *this* directory onwards for BehavCam_0 folders.
root_directory=$(pwd)

minimum_size=1M # minimum video file size; default is 1M (1 megabyte)
minimum_number=12 # minimum number of video files; set this to 1 if you've already concatenated your videos
concatenate_videos="True" # set to False if you do not wish to concatenate videos before running DLC

compute="CPU" # do you want to use GPU or CPU?

# location of the config file for your trained DLC algorithm. This will be copied into the python script (e.g., DLC_traces.py)
CONFIG='/lustre03/project/6049321/m3group/DLC/cozee_touchscreen-coco-2022-04-03/config.yaml'

# location of your DLC environment (including the activation command)
# If you don't have one, run DLC_setup.sl in your home directory first
ENV='/home/haqqeez/DLC_env/bin/activate'

# absolute path to your DLC scripts direcory (like DLC_traces.py, DLC_traces.sl, etc.)
# make sure there is NO '/' at the end of this path
MY_DLC_SCRIPTS_DIRECTORY='/lustre03/project/rpp-markpb68/m3group/Haqqee/GitHub/DLC'

########################################################################################
## Should not need to change anything below this line, unless you know what you're doing!

data=$(find $root_directory -type d -name "BehavCam_0")
taskname="DLC"
end="_concat"

if [ $compute == "GPU" ] && [ $concatenate_videos == "True" ]; then
	echo 0
	jobscript=DLC_concat_traces.sl
elif [ $compute == "CPU" ] && [ $concatenate_videos == "True" ]; then
	echo 1
	jobscript=DLC_concat_traces_cpu.sl
elif [ $compute == "GPU" ] && [ $concatenate_videos == "False" ]; then
	jobscript=DLC_traces.sl
	echo 3
elif [ $compute == "CPU" ] && [ $concatenate_videos == "False" ]; then
	jobscript=DLC_traces_cpu.sl
	echo 4
else
	echo "ERROR: Please choose valid compute and concatenation settings."
fi

echo $jobscript

for session in $data
do
	cd $session
	numVideos=$(find -maxdepth 1 -type f -name "*.avi" | wc -l)
	videoThreshold=$(find -type f -size +$minimum_size -name "*.avi" | wc -l)
	concat_check=$(find -type f -name "*concat.avi" | wc -l)
	DLC_data=$(find -type f -name "*DLC*.csv" | wc -l)

	if (( $DLC_data > 0 )); then
		#echo "DONE $session it is already analyzed"
		true
	elif (( $numVideos < $minimum_number )); then
		echo "SKIPPED: too few video files to analyze $session"
	elif (( $numVideos < $videoThreshold )); then
		echo "ERROR: Some video files may be too small or corrupt in $session"

	elif [ -f "0.avi" ] || (( $concat_check == 1 )); then
		echo "Analyzing $session"
		ID=$initials${session#*$initials}
		ID=${ID::$IDlength}
		date=202${session#*202}; date=${date::10}
		animalID="$ID-$date$end"
		ID="$taskname-$ID-$date"

		if (( $numVideos > 0 )); then
			cp "$MY_DLC_SCRIPTS_DIRECTORY/$jobscript" .
			cp $MY_DLC_SCRIPTS_DIRECTORY/DLC_traces.py .
			sleep 2
			sed -i -e "s|CONFIGPATH|$CONFIG|g" DLC_traces.py
			sed -i -e "s|ENVPATH|$ENV|g" $jobscript
			sed -i -e "s|TASKNAME|$ID|g" $jobscript
			sed -i -e "s|MYID|$animalID|g" $jobscript
			sed -i -e "s|MYEMAIL|$email|g" $jobscript
			sbatch $jobscript
			#sleep 2
		fi

	else
		echo "ERROR: Not compatible for analysis; check videos in $session"
	fi

done
