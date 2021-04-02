#!/bin/bash
#SBATCH --job-name=DLCtest
#SBATCH --account=rpp-markpb68
#SBATCH --time=0:45:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8000
#SBATCH --mail-user=computezee@gmail.com
#SBATCH --mail-type=ALL

module load StdEnv/2018.3
module load python/3.6

source ./DLCenv/bin/activate

export DLClight=True

echo "TESTING GPU"

nvcc -V

nvidia-smi

echo "TESTING NOW"

python testscript.py
