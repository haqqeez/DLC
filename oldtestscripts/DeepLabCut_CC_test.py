import deeplabcut
import os

#The following directory is the location of the config file of the DLC trained network that is going to be use for tracking.
config_path = '/home/mohammad/TUNL_VAME-Andres-2020-08-23/config.yaml'

# direction to the folder that containes all of the behavioural recordings in .avi format. The folder sould not contain other videos like ms videos with .avi format.
directory = '/home/mohammad/M3Analysis/Mosser/Raw/TUNLtask/Data/CA3/CAMCA3080/2021_02_09_MustTouch/09_30_20/BehavCam_0'

#The following finds all of the videos with .avi format to be DLC processed.
video = [directory + '/' + j for j in os.listdir(directory) if '.avi' in j]


# this for look goes over all videos and processed them.
for j in range(len(video)):
      deeplabcut.analyze_videos(config_path, [video[j]], save_as_csv=True)
