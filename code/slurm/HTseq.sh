#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J htseq_count
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anna2860@student.uu.se
#SBATCH --output=htseq_count_%j.out
#SBATCH --error=htseq_count_%j.err

# Load modules
module load bioinfo-tools
module load htseq

# Define paths
GFF_DIR="/home/anirudh/GA_Lab/New_Prokka_HighQ_output"    # Prokka GFF annotations
BAM_DIR="/home/anirudh/GA_Lab/final_mapped_reads"      # Sorted RNA BAM files
OUTPUT_DIR="/home/anirudh/GA_Lab/htseq_counts_2"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Run HTSeq-count on each BAM file
for BAM_FILE in ${BAM_DIR}/*_rna.bam; do
    BASENAME=$(basename "$BAM_FILE" _rna.bam)
    CLEAN_NAME=$(echo "$BASENAME" | sed 's/^D[13]//')  # Remove D1 or D3 prefix
    GFF_FILE="${GFF_DIR}/${CLEAN_NAME}/${CLEAN_NAME}.cleaned.gff"

    echo "Processing ${BASENAME}..."


    if [ ! -f "$GFF_FILE" ]; then
        echo "⚠️  GFF file not found: $GFF_FILE. Skipping $BASENAME."
        continue
    fi

    htseq-count \
        -f bam \
        -r pos \
        -s no \
        -t CDS \
        -i ID \
        "${BAM_FILE}" \
        "${GFF_FILE}" > "${OUTPUT_DIR}/${BASENAME}_counts.txt"

    echo "Counts saved to ${OUTPUT_DIR}/${BASENAME}_counts.txt"
done

echo "HTSeq-count analysis completed!"

