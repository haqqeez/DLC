#!/bin/bash
#SBATCH --job-name=DLC_project_training
#SBATCH --account=def-markpb68
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=80000
#SBATCH --mail-user=computezee@gmail.com
#SBATCH --mail-type=ALL

module load scipy-stack/2021a
module load python/3.8

# source to location of your DLC_env environment below

source /home/haqqeez/DLC_env/bin/activate

export DLClight=True

echo "TESTING GPU"

nvidia-smi

echo "TRAINING NOW"

python train_test.py

# NOTE: train_test.py stops at around 767000 iterations. Need to increase memory if you want more iterations (not sure why)
