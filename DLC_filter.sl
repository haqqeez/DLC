#!/bin/bash
#SBATCH --job-name=filt-TASKNAME
#SBATCH --account=rrg-markpb68
#SBATCH --nodes=1
#SBATCH --time=0:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4000
#SBATCH --mail-user=MYEMAIL
#SBATCH --mail-type=ALL

# module load scipy-stack
# module load StdEnv/2023
# module load python
# module load gcc
# module load opencv

module purge
module load StdEnv/2020
module load python/3.10
module load cuda/11.4 # maybe optional
module load cudnn/8.2.0 # maybe optional
  
### change below to source YOUR home directory containing DLC_env

source /home/haqqeez/DLC_oldenv/bin/activate

export DLClight=True

python DLC_filter.py
