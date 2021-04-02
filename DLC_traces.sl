#!/bin/bash
#SBATCH --job-name=TASKNAME
#SBATCH --account=rpp-markpb68
#SBATCH --time=0:40:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4000
#SBATCH --mail-user=MYEMAIL
#SBATCH --mail-type=ALL

module load StdEnv/2018.3
module load python/3.6

source /lustre03/project/rpp-markpb68/m3group/DLC/DLCenv/bin/activate

export DLClight=True

echo "TESTING GPU"

nvcc -V

nvidia-smi

echo "RUNNING NOW"

python DLC_traces.py
