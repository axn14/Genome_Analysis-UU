#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 04:00:00
#SBATCH -J prokka_bins
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anna2860@student.uu.se
#SBATCH --output=%x.%j.out

module load bioinfo-tools
module load prokka

BIN_DIR="/home/anirudh/GA_Lab/Binning/New_HighQ_files"
OUT_DIR="/home/anirudh/GA_Lab/New_Prokka_HighQ_output"

mkdir -p "$OUT_DIR"

for bin in "$BIN_DIR"/*.fa; do
    BASENAME=$(basename "$bin" .fa)
    prokka "$bin" --outdir "$OUT_DIR/$BASENAME" --prefix "$BASENAME"
done

echo "Prokka annotation complete for all bins."

