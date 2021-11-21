import deeplabcut
import os

# direction to the folder that containes all of the behavioural recordings in .avi format. Set to current working directory by default.
my_videos_directory = os.getcwd() + '/'

#The following directory is the location of the config file of the DLC trained network that is going to be use for tracking. Current directory by default.
path_config = my_videos_directory + '/' + 'config.yaml'

print('-----FILTERING-----')

deeplabcut.filterpredictions(path_config, [my_videos_directory], filtertype= 'median', save_as_csv=True)

print('----DONE----')
