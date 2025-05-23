#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:20:00
#SBATCH -J preprocessing_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user anna2860@student.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load samtools
module load FastQC

#run fastQC

fastqc ./trimmed/SRR4342129_1.paired.trimmed.fastq.gz ./trimmed/SRR4342129_2.paired.trimmed.fastq.gz -o trimmed_QC
fastqc ./trimmed/SRR4342133_1.paired.trimmed.fastq.gz ./trimmed/SRR4342133_2.paired.trimmed.fastq.gz -o trimmed_QC
fastqc ./untrimmed/SRR4342137.1.paired.trimmed.fastq.gz ./untrimmed/SRR4342137.2.paired.trimmed.fastq.gz -o untrimmed_QC
fastqc ./untrimmed/SRR4342139.1.paired.trimmed.fastq.gz ./untrimmed/SRR4342139.2.paired.trimmed.fastq.gz -o untrimmed_QC
