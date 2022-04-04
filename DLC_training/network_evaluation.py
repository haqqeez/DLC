import deeplabcut

# absolute path to config file
# example: '/lustre03/project/rpp-markpb68/m3group/DLC/cozee_touchscreen-coco-2021-03-08/config.yaml'
path_config = '/absolute/path/to/config.yaml'

print('------------------------Begin evaluation!')

deeplabcut.evaluate_network(path_config)

# other scripts you can use:

#print('---------------------plotting trajectories')

#deeplabcut.plot_trajectories(path_config,['/home/haqqeez/projects/rpp-markpb68/m3group/DLC/test_videos/'])


#print('-----------------------label videos')

#deeplabcut.create_labeled_video(path_config, ['/home/haqqeez/projects/rpp-markpb68/m3group/DLC/test_videos/vids/'], save_frames=True)

print('Done!')
