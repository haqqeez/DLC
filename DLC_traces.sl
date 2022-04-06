#!/bin/bash
#SBATCH --job-name=TASKNAME
#SBATCH --account=def-markpb68
#SBATCH --time=0:14:50
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6000
#SBATCH --mail-user=MYEMAIL
#SBATCH --mail-type=ALL

module load scipy-stack/2021a
module load python/3.8
  
# source YOUR home directory containing DLC_env
# e.g., /home/haqqeez/DLC_env/bin/activate
# leave as (capital letters) envpath if using ParallelDLC.sh

source ENVPATH

export DLClight=True

echo "TESTING GPU"

nvidia-smi

echo "RUNNING NOW"

python DLC_traces.py
