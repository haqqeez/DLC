import deeplabcut
import os
import glob

# absolute path to config.yaml for DLC algorithm you want to use for analysis
# example: '/lustre03/project/rpp-markpb68/m3group/DLC/cozee_touchscreen-coco-2022-04-03/'
# leave as (capital letters) 'configpath' if using ParallelDLC.sh

path_config = 'CONFIGPATH'

# direction to the folder that containes all of the behavioural recordings in .avi format. Set to current working directory by default.
# set to current working directory by deafult
my_videos_directory = os.getcwd() + '/'

print('----------------------ANALYZING NOW----------------------')

deeplabcut.analyze_videos(path_config, [my_videos_directory], save_as_csv=True)

print('-----FILTERING-----')

deeplabcut.filterpredictions(path_config, [my_videos_directory], filtertype= 'median', save_as_csv=True)

print('----RENAMING----')

filepath = os.getcwd()

# collect all appropriate csv files
all_files = glob.glob(filepath + f"/*concat*DLC*filtered.csv")

# loop through each RAW file and return modified file, renamed
for file in all_files:
    if 'concat' in file:
        splits = file.split('/')
        animal_ID = splits[-7]
        date = splits[-4]
        newname = f'{animal_ID}_{date}_filtered.csv'
        print(newname)

        path = '/'.join(splits[:-1])+'/'
        newpath = path+newname
        os.rename(file,newpath)
        print(f'renamed {file} to {newpath}')
        
#### Next, rename the non-filtered DLC csv ########

# collect all appropriate csv files
all_files = glob.glob(filepath + f"/*concat*DLC*.csv")

# loop through each RAW file and return modified file, renamed
for file in all_files:
    if 'concat' in file:
        splits = file.split('/')
        animal_ID = splits[-7]
        date = splits[-4]
        newname = f'{animal_ID}_{date}_DLC.csv'
        print(newname)

        path = '/'.join(splits[:-1])+'/'
        newpath = path+newname
        os.rename(file,newpath)
        print(f'renamed {file} to {newpath}')
        
print('----DONE----')
