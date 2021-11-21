#!/bin/bash
#SBATCH --job-name=filt-TASKNAME
#SBATCH --account=rpp-markpb68
#SBATCH --nodes=1
#SBATCH --time=0:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=4000
#SBATCH --mail-user=MYEMAIL
#SBATCH --mail-type=ALL

module load StdEnv/2018.3
module load python/3.6

source /lustre03/project/rpp-markpb68/m3group/DLC/DLC_env/bin/activate

export DLClight=True

python DLC_filter.py
