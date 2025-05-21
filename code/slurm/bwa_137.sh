#!/bin/bash
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:00:00
#SBATCH -J rna_mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anna2860@student.uu.se
#SBATCH -o /home/anirudh/GA_Lab/mapping_results/rnamapping%j.out
#SBATCH -e /home/anirudh/GA_Lab/mapping_results/rnamapping%j.err


# Load required modules
module load bioinfo-tools
module load bwa
module load samtools

# Define input and output paths
BIN_DIR="/home/anirudh/GA_Lab/Binning/New_HighQ_files"
READ1="/home/anirudh/GA_Lab/RNA_trimmed/SRR4342137_1_trimmed.fastq.gz"
READ2="/home/anirudh/GA_Lab/RNA_trimmed/SRR4342137_2_trimmed.fastq.gz"
OUTDIR="/home/anirudh/GA_Lab/new_mapping_results_137"

# Create output directory if it doesn't exist
mkdir -p "$OUTDIR"

# Loop through each bin and map RNA reads
for BIN in ${BIN_DIR}/*.fa; do
    BIN_NAME=$(basename "$BIN" .fa)
    echo "Processing $BIN_NAME..."

    # Index the bin
    bwa index "$BIN"

    # Align reads and sort output BAM
    bwa mem -t 4 "$BIN" "$READ1" "$READ2" | \
        samtools view -bS - | \
        samtools sort -@ 4 -o "${OUTDIR}/${BIN_NAME}_rna.bam" -

    # Index the BAM file
    samtools index "${OUTDIR}/${BIN_NAME}_rna.bam"
done

echo "RNA mapping complete!"
