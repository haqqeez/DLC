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

module load scipy-stack/2021a
module load python/3.8
  
### change below to source YOUR home directory containing DLC_env

source /home/haqqeez/DLC_env/bin/activate

export DLClight=True

python DLC_filter.py
