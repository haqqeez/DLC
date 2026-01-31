#!/bin/bash
#SBATCH --job-name=TASKNAME
#SBATCH --account=def-markpb68
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8000
#SBATCH --mail-user=MYEMAIL
#SBATCH --mail-type=ALL

# module load scipy-stack/2021a
# module load python/3.8

module purge
module load StdEnv/2020
module load python/3.10
module load cuda/11.4 # maybe optional
module load cudnn/8.2.0 # maybe optional
  
### change below to source YOUR home directory containing DLC_env

source /home/haqqeez/DLC_oldenv/bin/activate

export DLClight=True

echo "TESTING GPU"

nvidia-smi

echo "RUNNING NOW"

python DLC_label.py
