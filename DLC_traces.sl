#!/bin/bash
#SBATCH --job-name=TASKNAME
#SBATCH --account=rpp-markpb68
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8000
#SBATCH --mail-user=MYEMAIL
#SBATCH --mail-type=ALL

module load scipy-stack/2021a
module load python/3.8
  
### change below to source YOUR home directory containing DLC_env

source /home/haqqeez/DLC_env/bin/activate

export DLClight=True

echo "TESTING GPU"

nvidia-smi

echo "RUNNING NOW"

python DLC_traces.py
