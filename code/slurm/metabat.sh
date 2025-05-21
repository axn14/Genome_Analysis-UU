#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J metabat_binning
#SBATCH --mail-type=ALL
#SBATCH --mail-user anna2860@student.uu.se

module load bioinfo-tools
module load MetaBat

cd /home/anirudh/GA_Lab/megahit_result

metabat2 -t 4 -i /home/anirudh/GA_Lab/megahit_result/final.contigs.fa -o /home/anirudh/GA_Lab/Binning/New_Binning_output -m 2500 --maxEdges 200 --maxP 92 --minS 60 -s 200

echo "Megahit Binning complete"
