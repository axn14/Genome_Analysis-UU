#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 07:00:00
#SBATCH -J bwa_mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anna2860@student.uu.se
#SBATCH --output=%x.%j.out

# Load required modules
module load bioinfo-tools
module load bwa
module load samtools/1.9

# Paths
REFERENCE="/home/anirudh/GA_Lab/Binning/HighQ_files"   # <- Your reference assembly
READ1_1="/home/anirudh/GA_Lab/RNA_trimmed/SRR4342137_1_trimmed.fastq.gz"           # <- Forward reads
READ2_1="/home/anirudh/GA_Lab/RNA_trimmed/SRR4342137_2_trimmed.fastq.gz"           # <- Reverse reads
READ1_2="/home/anirudh/GA_Lab/RNA_trimmed/SRR4342139_1_trimmed.fastq.gz"
READ2_2="/home/anirudh/GA_Lab/RNA_trimmed/SRR4342139_2_trimmed.fastq.gz"
OUTDIR="/home/anirudh/GA_Lab/mapping_results"

# Create output directory if it doesn't exist
mkdir -p "$OUTDIR"

for BIN in "$REFERENCE"/*.fa; do
	BASENAME=$(basename "$BIN".fa)
	echo "processing $BASENAME..."
	
# 1. Index the reference genome (only needs to be done once!)
	bwa index "$BIN"

# 2. Mapping reads to the reference genome
	bwa mem -t 4 "$BIN" "$READ1_1" "$READ2_1" | samtools view -Sb -> "$OUTDIR/${BASENAME}_reads_1.bam" \
	bwa mem -t 4 "$BIN" "$READ1_2" "$READ2_2" | samtools view -Sb -> "$OUTDIR/${BASENAME}_reads_2.bam"

# 3. Sort BAM file	
	samtools sort "$OUTDIR/${BASENAME}_reads_1.bam" -o "$OUTDIR/${BASENAME}_reads_1.sorted.bam" \
	samtools sort "$OUTDIR/${BASENAME}_reads_2.bam" -o "$OUTDIR/${BASENAME}_reads_2.sorted.bam"

	# 4. Index the sorted BAM file
	samtools index "$OUTDIR/${BASENAME}_reads_1.sorted.bam" \
	samtools index "$OUTDIR/${BASENAME}_reads_2.sorted.bam"
	
	# 5. Remove unsorted BAM
        rm "$OUTDIR/${BASENAME}_reads_1.sorted.bam" "$OUTDIR/${BASENAME}_reads_2.sorted.bam"

        echo " Finished mapping for $BASENAME"

done

# 5. (Optional) Remove the unsorted (if wanted, add below later)


echo "BWA mapping complete!"

