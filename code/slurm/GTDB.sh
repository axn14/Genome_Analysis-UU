#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 04:00:00
#SBATCH -J gtdbtk_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anirudh@rackham.uppmax.uu.se
#SBATCH --output=%x.%j.out

# Load modules
module load bioinfo-tools
module load GTDB-Tk/2.4.0

# Define input and output directories
BINS_DIR="/home/anirudh/GA_Lab/Binning/New_HighQ_files"
GTDB_OUT="/home/anirudh/GA_Lab/New_GTDB_output"

# Create output directory if it doesn't exist
mkdir -p "$GTDB_OUT_HighQ"

# Run GTDB-Tk classify workflow
gtdbtk classify_wf \
  --genome_dir "$BINS_DIR" \
  --out_dir "$GTDB_OUT" --extension fa \
  --cpus 16 --skip_ani_screen

echo "GTDB-Tk classification complete!"

