#!/bin/bash
#SBATCH --job-name=TASKNAME
#SBATCH --account=def-wilsyl
#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=20000
#SBATCH --mail-user=MYEMAIL
#SBATCH --mail-type=ALL

# module load scipy-stack/2021a
# module load python/3.8
module purge
module load StdEnv/2020
module load python/3.10
module load cuda/11.4 # maybe optional
module load cudnn/8.2.0 # maybe optional
  
# source YOUR home directory containing DLC_env
# e.g., /home/haqqeez/DLC_env/bin/activate
# leave as (capital letters) envpath if using ParallelDLC.sh

source ENVPATH

export DLClight=True

echo "RUNNING NOW"

python DLC_traces.py
