#!/bin/bash

# Specify the path to the CSV file
CSV_FILE="new_400_Screening_Results.csv"

# Specify the directory to save the converted PDB files
PDB_DIR="pdb"

# Create the output directory if it doesn't exist
mkdir -p "$PDB_DIR"

# Initialize a counter for sequential naming
counter=1

# Read the SMILES strings from the CSV file line by line
cat "$CSV_FILE" | while read -r smiles; do
    # Set the output PDB filename using a simple sequential name
    output_pdb_file="$PDB_DIR/structure_${counter}.pdb"
    
    # Convert SMILES to PDB with 3D coordinates using obabel
    echo "$smiles" | obabel -ismi -o pdb --gen3d -O "$output_pdb_file"
    
    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        echo "Converted SMILES to PDB: $output_pdb_file"
    else
        echo "Error converting SMILES: $smiles"
    fi
    
    # Increment the counter
    counter=$((counter + 1))
done
