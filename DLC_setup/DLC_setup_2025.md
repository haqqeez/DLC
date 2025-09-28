################################################################################################

## WARNING ###

### MAKE SURE YOU ARE IN YOUR HOME DIRECTORY! NOT PROJECTS! ##
#### PLEASE DO NOT INSTALL IN PROJECTS! ###
### e.g., if you type "pwd" you get: /home/haqqeez

# Run each line below manually in the terminal
# It is usually the case that it works better line by line from the terminal

# Note that all features that do NOT requirea GUI will work with this version of DLC. 

################################################################################################

module load scipy-stack
module load StdEnv/2023
module load python/3.10
module load gcc/12.3
module load opencv/4.10.0

virtualenv --no-download DLC_env
source DLC_env/bin/activate

python -m pip install --upgrade pip
git clone https://github.com/DeepLabCut/DeepLabCut.git
cd DeepLabCut/
pip install .
