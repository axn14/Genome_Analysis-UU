#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J samtools_abundance
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anna2860@student.uu.se
#SBATCH --output=samtools_abundance_%j.out
#SBATCH --error=samtools_abundance_%j.err

# Load required modules
module load bioinfo-tools
module load samtools

# Define input/output
BAM_DIR="/home/anirudh/GA_Lab/final_mapped_reads"          # Directory with binXXX_rna.bam files
OUTDIR="/home/anirudh/GA_Lab/bin_abundance/samtools_depth"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop over each BAM file and calculate depth
for BAM in ${BAM_DIR}/D[13]bin*_rna.bam; do
    BASENAME=$(basename "$BAM" _rna.bam)
    CLEAN_NAME=$(echo "$BASENAME" | sed 's/^D[13]//')      # bin286 (no D1/D3)
    OUTFILE="${OUTDIR}/${CLEAN_NAME}_depth.txt"

    echo "Processing $BASENAME"

    # Run samtools depth
    samtools depth "$BAM" > "$OUTFILE"

    echo "Depth written to $OUTFILE"
done

echo "All samtools depth calculations completed!"

echo "Abundance matrix created at $OUTPUT_DEPTH"

