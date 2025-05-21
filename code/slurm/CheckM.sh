#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J checkm_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anna2860@student.uu.se
#SBATCH --output=%x.%j.out

# 1) Load modules
module load bioinfo-tools
module load CheckM

# 2) Define input (the directory containing the MetaBAT bins) and output
BINS_DIR="/home/anirudh/GA_Lab/Binning/new_renamed_bins"
CHECKM_OUT="/home/anirudh/GA_Lab/New_CheckM_out"

# 3) Run CheckM lineage_wf

checkm lineage_wf \
    -x fa \
    -t 6 -f $CHECKM_OUT/checkm_summary.txt \
    --reduced_tree \
    "$BINS_DIR" \
    "$CHECKM_OUT"

echo "CheckM analysis complete!"

