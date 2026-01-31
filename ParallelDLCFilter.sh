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

# location of the config file for your trained DLC algorithm. This will be copied into folder where DLC is run, for convenience.
config_file='/lustre09/project/rrg-markpb68/m3group/DLC/cozee_touchscreen-coco-2021-03-08/config.yaml'

########################################################################################

data=$(find $root_directory -type d -name "BehavCam_0")
taskname="DLC"

for session in $data
do
	cd $session
	filt_check=$(find -type f -name "*filtered.csv" | wc -l)
	DLC_data=$(find -type f -name "*DLC*.csv" | wc -l)

	if (( $DLC_data < 1 )); then
		echo "NO DLC FOUND $session is not yet analyzed"
	elif (( $filt_check > 0 )); then
		echo "DONE: $session is already filtered!"
	elif (( $filt_check == 0 )); then
		echo "Filtering $session"
		ID=$initials${session#*$initials}
		ID=${ID::$IDlength}
		date=202${session#*202}; date=${date::10}
		animalID="$ID-$date$end"
		ID="$taskname-$ID-$date"

		cp /lustre09/project/rrg-markpb68/m3group/Haqqee/GitHub/DLC/DLC_filter.sl .
		cp /lustre09/project/rrg-markpb68/m3group/Haqqee/GitHub/DLC/DLC_filter.py .
		cp $config_file .
		sleep 2
		sed -i -e "s/TASKNAME/$ID/g" DLC_filter.sl
		sed -i -e "s/MYEMAIL/$email/g" DLC_filter.sl
		sbatch DLC_filter.sl
		sleep 2

	else
		echo "ERROR: Not compatible for analysis; check videos in $session"
	fi
done
