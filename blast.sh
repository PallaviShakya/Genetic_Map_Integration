#!/bin/bash

genome_file="path/to/genome.fasta"
fasta_directory="~directory/Seq_to_BLAST"
output_directory="path/to/output/blast/files"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Loop over all fasta files in the directory
for fasta_file in "$fasta_directory"/*.fasta; do
  # Extract the filename without the extension
  filename=$(basename "$fasta_file" .fasta)
  
  # Output blast file path
  output_file="$output_directory/$filename.blast"
  
  # Perform BLAST and save the output to the blast file
  blastn -query "$fasta_file" -db new_genome -outfmt 6 -max_target_seqs 1 -max_hsps 1 > $filename.tsv
  
done