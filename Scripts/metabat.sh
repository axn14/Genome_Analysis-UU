#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J metabat_binning
#SBATCH --mail-type=ALL
#SBATCH --mail-user anna2860@student.uu.se

module load bioinfo-tools
module load MetaBat

cd /home/anirudh/GA_Lab/megahit_result

metabat2 -t 2 -i /home/anirudh/GA_Lab/megahit_result/final.contigs.fa -o /home/anirudh/GA_Lab/Binning/Binning_output

echo "Megahit Binning complete"
