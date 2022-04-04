import deeplabcut

# absolute path to your config file
# example: '/lustre03/project/rpp-markpb68/m3group/DLC/cozee_touchscreen-coco-2022-04-03/config.yaml'
path_config = '/absolute/path/to/config.yaml'

print('Begin training!')

deeplabcut.train_network(path_config, maxiters=768000) # WARNING: If you increase maxiters, be sure to increase RAM in DLC_training.sl script!

print('Done!')
