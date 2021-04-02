#!/bin/bash

########################################################################################

### Enter your 3-letter initials below; this is used to name jobs based on Animal ID
### Note that this and the email input are both OPTIONAL! If you put nothing, or put something incorrect, the script will still launch your jobs.
###### Just the job names might look strange and you won't get e-mail notifications
initials="ZHA"

### Enter your e-mail below
email="email@email.email"

### Enter the full parent directory for analysis in the () brackets (default is pwd)
### The script will search from *this* directory onwards for BehavCam_0 folders.
pwd=$(pwd)

minimum_size=1M # minimum video file size
minimum_number=3 #minimum number of video files
concatenate_videos="True" # set to False if you do not wish to concatenate videos before running DLC

# location of the config file for your trained DLC algorithm. This will be copied into folder where DLC is run, for convenience.
config_file='/lustre03/project/6049321/m3group/DLC/cozee_touchscreen-coco-2021-03-08/config.yaml'

########################################################################################

data=$(find $pwd -type d -name "BehavCam_0")
taskname="DLC"
end="_concat"

for session in $data
do
	cd $session
	numVideos=$(ls -1q *.avi | wc -l)
	videoThreshold=$(find -type f -size +$minimum_size -name "*.avi" | wc -l)
	concat_check=$(find -type f -name "*_concat.avi" | wc -l)
	DLC_data=$(find -type f -name "*DLC*.csv" | wc -l)

	if (( $DLC_data > 0 )); then
		echo "DONE $session it is already analyzed"
	elif (( $numVideos < $minimum_number )); then
		echo "SKIPPED: too few video files to analyze $session"
	elif (( $numVideos < $videoThreshold )); then
		echo "ERROR: Some video files may be too small or corrupt in $session"

	elif [ -f "0.avi" ] || (( $concat_check == 1 )); then
		echo "Analyzing $session"
		ID=$initials${session#*$initials}
		ID=${ID::6}
		date=202${session#*202}; date=${date::10}
		animalID="$ID-$date-$end"
		ID="$taskname-$ID-$date"

		if (( $concatenate_videos == "True" )) && (( $numVideos > 1 )); then
			cp /lustre03/project/rpp-markpb68/m3group/Haqqee/GitHub/SLURMstuff/DLC_concat_traces.sl .
			cp /lustre03/project/rpp-markpb68/m3group/Haqqee/GitHub/SLURMstuff/DLC_traces.py .
			cp $config_file .
			sleep 2
			sed -i -e "s/TASKNAME/$ID/g" DLC_concat_traces.sl
			sed -i -e "s/MYID/$animalID/g" DLC_concat_traces.sl
			sed -i -e "s/MYEMAIL/$email/g" DLC_concat_traces.sl
			sbatch DLC_concat_traces.sl
			sleep 2
		else
			cp /lustre03/project/rpp-markpb68/m3group/Haqqee/GitHub/SLURMstuff/DLC_traces.sl .
			cp /lustre03/project/rpp-markpb68/m3group/Haqqee/GitHub/SLURMstuff/DLC_traces.py .
			cp $config_file .
			sleep 2
			sed -i -e "s/TASKNAME/$ID/g" DLC_traces.sl
			sed -i -e "s/MYEMAIL/$email/g" DLC_traces.sl
			sbatch DLC_traces.sl
			sleep 2
		fi

	else
		echo "ERROR: Not compatible for analysis; check videos in $session"
	fi
done
