#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J trimmomatic_rna_paper3
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anirudh@rackham.uppmax.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load trimmomatic/0.39

# Define directories
INPUT_DIR=/home/anirudh/GA_Lab
OUTPUT_DIR=/home/anirudh/Genome_Analysis-UU/Scripts/RNA_trimmed
LOG_DIR=/home/anirudh/Genome_Analysis-UU/Scripts/logs

# Create directory
mkdir -p $LOG_DIR
mkdir -p $OUTPUT_DIR

# Process each pair of samples
SAMPLES=("SRR4342137" "SRR4342139")

for SAMPLE in "${SAMPLES[@]}"; do
    echo "Processing $SAMPLE"

    java -jar $TRIMMOMATIC_HOME/trimmomatic-0.39.jar PE \
        -threads 2 \
        -phred33 \
        $INPUT_DIR/${SAMPLE}.1.fastq.gz \
        $INPUT_DIR/${SAMPLE}.2.fastq.gz \
        $OUTPUT_DIR/${SAMPLE}_1_trimmed.fastq.gz \
        $OUTPUT_DIR/${SAMPLE}_1_unpaired.fastq.gz \
        $OUTPUT_DIR/${SAMPLE}_2_trimmed.fastq.gz \
        $OUTPUT_DIR/${SAMPLE}_2_unpaired.fastq.gz \
        ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-PE.fa:2:30:10 \
        LEADING:3 \
        TRAILING:3 \
        SLIDINGWINDOW:4:15 \
        MINLEN:36 \
        > $LOG_DIR/${SAMPLE}_trimmomatic.log 2>&1
done

echo "Trimming completed for all samples"
