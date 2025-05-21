#!/bin/bash -l
#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 06:00:00
#SBATCH -J metabolic_reconstruction
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anna2860@student.uu.se
#SBATCH --output=metabolic_recon_%j.out
#SBATCH --error=metabolic_recon_%j.err

# Load modules
module load bioinfo-tools
module load eggNOG-mapper/2.1.9

# Define input and output
FAA_DIR="/home/anirudh/GA_Lab/analyses/New_Prokka_HighQ_output"      # Directory with binXXX.faa files
OUT_DIR="/home/anirudh/GA_Lab/Metabolic_reconstruction"
KO_DIR="$OUT_DIR/KO_lists"

mkdir -p "$OUT_DIR"
mkdir -p "$KO_DIR"

# Step 1: Run eggNOG-mapper on each bin
for FAA in ${FAA_DIR}/bin*/bin*.faa; do
    BASENAME=$(basename "$FAA" .faa)
    echo "Annotating $BASENAME with eggNOG-mapper"

    emapper.py -i "$FAA" \
        -o "${OUT_DIR}/${BASENAME}_annot" \
        --cpu 4 \
        --itype proteins \
        --output_dir "$OUT_DIR"

    # Step 2: Extract KEGG Orthologs (KOs)
    echo " Extracting KEGG Orthologs for $BASENAME"
    awk -F '\t' '{ if ($6 ~ /^K[0-9]+$/) print $6 }' "${OUT_DIR}/${BASENAME}_annot.emapper.annotations" | sort | uniq > "${KO_DIR}/${BASENAME}_KOs.txt"
done

echo "KEGG Ortholog extraction complete."

# Step 3: Summary message
echo "¯ All bins annotated. KEGG KO lists ready in $KO_DIR"
echo "Use these KO lists with KEGG Mapper (https://www.genome.jp/kegg/tool/map_pathway2.html) for pathway reconstruction."


