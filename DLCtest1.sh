#!/bin/bash
#SBATCH --job-name=DLCtest
#SBATCH --account=rpp-markpb68
#SBATCH --time=0:45:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8000
#SBATCH --mail-user=computezee@gmail.com
#SBATCH --mail-type=ALL

module load python/3.7

virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate

pip install --no-index --upgrade pip
module load StdEnv/2020

pip install --no-index tensorflow_cpu
pip install wxPython
pip install cython
pip install deeplabcut
pip install tensorflow_cpu==1.15.0

export DLClight=True

python testscript.py
