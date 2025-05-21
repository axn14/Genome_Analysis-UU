#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J quast_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user anna2860@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load quast/5.0.2

# Run QUAST
quast.py \
  /home/anirudh/GA_Lab/megahit_result/final.contigs.fa \
  -o /home/anirudh/GA_Lab/quast_output \
  --threads 4 \
  --min-contig 500

echo "QUAST analysis complete!"

