#!/bin/bash

# Define the receptor and docking box parameters
receptor="pmk111.pdbqt"
center_x=1.3412   # X coordinate of the docking box center
center_y=1.0948   # Y coordinate of the docking box center
center_z=3.6980   # Z coordinate of the docking box center
size_x=25         # Size of the docking box along the X axis
size_y=25         # Size of the docking box along the Y axis
size_z=25         # Size of the docking box along the Z axis

# Create output directory for results
output_dir="docking_results"
mkdir -p $output_dir

# Loop through all .pdbqt ligand files in the ligands_pdbqt directory
for ligand in ligands_pdbqt/*.pdbqt; do
    ligand_name=$(basename "$ligand" .pdbqt)

    # Run AutoDock Vina for each ligand
    vina --receptor $receptor --ligand "$ligand" \
         --center_x $center_x --center_y $center_y --center_z $center_z \
         --size_x $size_x --size_y $size_y --size_z $size_z \
         --out "$output_dir/${ligand_name}_docked.pdbqt" > "$output_dir/${ligand_name}_log.txt"

    # Extract the docking score from the output file
    affinity=$(grep "REMARK VINA RESULT" "$output_dir/${ligand_name}_docked.pdbqt" | awk '{print $4}')
    echo "$ligand_name: $affinity kcal/mol" >> "$output_dir/docking_scores.txt"
done
