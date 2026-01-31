#!/bin/bash
#SBATCH --job-name=DLCsetup
#SBATCH --account=rpp-markpb68
#SBATCH --time=0:40:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --mail-user=computezee@gmail.com
#SBATCH --mail-type=ALL

################################################################################################

## WARNING ###

### MAKE SURE YOU ARE IN YOUR HOME DIRECTORY! NOT PROJECTS! ##
#### PLEASE DO NOT INSTALL IN PROJECTS! ###
### e.g., if you type "pwd" you get: /home/haqqeez

# if job doesn't work, you can try running each line below manually in the terminal

# Note that all features that do NOT requirea GUI will work with this version of DLC. 
# If you need GUI for labelling (and ONLY labelling), use existing environment in /lustre03/project/rpp-markpb68/m3group/DLC/DLC_env/

################################################################################################

## NOTE: This is outdated on rorqual 2026 onwards (Was designed for Beluga 2021-2025)

module load scipy-stack/2021a
module load python/3.8

virtualenv --no-download DLC_env
source DLC_env/bin/activate

pip install --no-index tensorflow
python -m pip install --upgrade pip
pip install --no-index deeplabcut
