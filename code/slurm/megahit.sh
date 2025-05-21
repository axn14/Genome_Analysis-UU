#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 07:00:00
#SBATCH -J megahit_DNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anirudh-dineshan.nair.2860@student.uu.se
#SBATCH --output=%x.%j.out

###############################
# 1) Load modules
###############################
module load bioinfo-tools
module load megahit
###############################

###############################
# 2) File connection
R1="/home/anirudh/GA_Lab/raw_data/SRR4342129_1.paired.trimmed.fastq.gz,/home/anirudh/GA_Lab/raw_data/SRR4342133_1.paired.trimmed.fastq.gz" 
R2="/home/anirudh/GA_Lab/raw_data/SRR4342129_2.paired.trimmed.fastq.gz,/home/anirudh/GA_Lab/raw_data/SRR4342133_2.paired.trimmed.fastq.gz"
###############################

###############################
# 3) Run MEGAHIT with Untrimmed Reads
###############################
# Sample's forward (R1) and reverse (R2) reads:
megahit \
  -1 $R1 \
  -2 $R2 \
  -o /home/anirudh/GA_Lab/megahit_result --force \
  --kmin-1pass \
  --k-list 69,79,89

echo "MEGAHIT run on untrimmed reads complete!"

