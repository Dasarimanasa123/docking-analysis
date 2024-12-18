#!/bin/bash

# Input SDF file with multiple molecules
input_sdf="molecules.sdf"

# Extract molecule names and convert each molecule to a separate PDB file
obabel -i sdf "$input_sdf" -o pdb -O "molecule.pdb" -m

# Loop through the generated files and rename them using the molecule name
for pdb_file in molecule*.pdb; do
    # Extract the molecule name from the PDB file using grep or head
    molecule_name=$(grep '^COMPND' "$pdb_file" | head -n 1 | awk '{print $2}')
    
    # If molecule name is found, rename the file; otherwise, use a generic name
    if [ -n "$molecule_name" ]; then
        mv "$pdb_file" "${molecule_name}.pdb"
    else
        echo "No molecule name found in $pdb_file; keeping default name."
    fi
done

echo "Conversion complete with molecule names as file names where possible."

