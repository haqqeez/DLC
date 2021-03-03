#!/bin/bash
#SBATCH --job-name=DLC_ZHA13_11_18
#SBATCH --account=rpp-markpb68
#SBATCH --time=0:50:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4000
#SBATCH --mail-user=computezee@gmail.com
#SBATCH --mail-type=ALL

module load StdEnv/2018.3
module load python/3.6

source ./test4/bin/activate

export DLClight=True

echo "TESTING GPU"

nvcc -V

nvidia-smi

echo "TESTING NOW"

python DeepLabCut_CC_test_zee.py
