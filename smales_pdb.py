import pandas as pd
from rdkit import Chem
from rdkit.Chem import AllChem

# Load CSV containing SMILES
df = pd.read_csv("smiles.csv")  # Replace with your CSV file name

# Assuming the column containing SMILES strings is named "SMILES"
for index, row in df.iterrows():
    smiles = row["SMILES"]
    mol = Chem.MolFromSmiles(smiles)
    
    if mol:  # Ensure the molecule was parsed correctly
        # Generate 3D coordinates
        mol = Chem.AddHs(mol)
        AllChem.EmbedMolecule(mol)
        AllChem.UFFOptimizeMolecule(mol)
        
        # Define the output PDB file name
        pdb_filename = f"molecule_{index+1}.pdb"
        
        # Write to PDB file
        with open(pdb_filename, "w") as f:
            f.write(Chem.MolToPDBBlock(mol))
        print(f"Saved {pdb_filename}")
    else:
        print(f"Error with SMILES at row {index+1}: {smiles}")

