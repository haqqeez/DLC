import deeplabcut
import os

# direction to config.yaml for DLC algorithm you want to use for analysis
# example: '/lustre03/project/rpp-markpb68/m3group/DLC/cozee_touchscreen-coco-2022-04-03/'
path_config = '/absolute//path/to/config.yaml'

# direction to the folder that containes all of the behavioural recordings in .avi format. Set to current working directory by default.
# set to current working directory by deafult
my_videos_directory = os.getcwd() + '/'

print('-----LABELLING-----')

deeplabcut.create_labeled_video(path_config, [my_videos_directory])

print('----DONE----')
