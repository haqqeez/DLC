#!/bin/bash

### NOTES ###

# This code sets up an old DeepLabCut environment (DLC v2.3.10 with TensorFlow 2.10.0) on a computing cluster.
# It loads specific module versions, creates a virtual environment, and installs the required packages.

# This installation process aims to replicate the environment used in analyses on Beluga from 2022-2025 as closely as possible
# It is best suited for generating traces from pre-existing DLC projects that were trained using the tensorflow 2.10.0 / DLC 2.3.10 setup.
# It might not work as intended for training new models or creating new DLC projects.

# Note that GPU support isn't very good / might be non-existent in StdEnv/2020 with more recent GPU architectures, particularly on Rorqual.
##### ~~~~ This is best used for CPU-based analyses with deeplabcut, not GPU ~~~~ ##### I have not tested GPU usage with this setup on Rorqual.

# If StdEnv/2020 becomes completely discontinued on the cluster, this setup may no longer function as intended.

################################### INSTRUCTIONS #################################

# To use this setup script, copy and paste the commands below in your LOGIN node in your HOME directory on the cluster (NOT in PROJECTS)

# First, get uv if you don't have it already:
curl -LsSf https://astral.sh/uv/install.sh | sh

# Then, run the following commands on your terminal to set up the old DLC environment
# (you can also run this script directly if you save it as oldDLCsetup2026.sh and give it execute permissions with chmod +x oldDLCsetup2026.sh)

module purge
module load StdEnv/2020
module load python/3.10
module load cuda/11.4 # note: this might not be needed if not using GPU, just in case
module load cudnn/8.2.0 # note: this might not be needed if not using GPU, just in case

virtualenv DLC_oldenv
source DLC_oldenv/bin/activate

pip install --no-index --upgrade pip
pip install --no-index tensorflow==2.10.0 # must use "--no-index" to ensure the tensorflow engine works on the cluster

# next we use uv pip without "--no-index" because this specific version of deeplabcut is not available via local wheels
# uv pip is also generally faster and more reliable on the cluster and less prone to connection timeouts
# TODO: This is not efficient. It installs way more than is necessary for DLC to work. Find a way to make existing wheels work
uv pip install deeplabcut==2.3.10 # this is the only version of DLC that seems to work with TF 2.10.0

pip install --no-index tensorpack
pip install --no-index tf_slim

# Verify installations
export DLClight=True # this avoids some issues with GUI on the cluster

python -c "import tensorflow as tf; print(f'TF: {tf.__version__}'); \
import deeplabcut; print(f'DLC: {deeplabcut.__version__}')"

# this should print TF: 2.10.0 and DLC: 2.3.10
# It might also print a bunch of warnings, which can be ignored

# I recommend testing this on an interactive session first to ensure everything is working properly before using it for analyses
# You can start an interactive session with: salloc --time=01:00:00 --cpus-per-task=4 --mem=16G
# make sure to load all modules as above and activate the virtual environment before running any DLC code

# for any questions, contact z.haqqee@gmail.com

