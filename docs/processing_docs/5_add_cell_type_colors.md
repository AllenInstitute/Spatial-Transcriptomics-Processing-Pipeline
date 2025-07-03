# Add Cell Type Colors
---
This module provides functionality to add standardized color mappings for cell type classifications to AnnData objects using the ABC atlas color scheme. It supports both flat and hierarchical mapping types and assigns consistent colors across different taxonomic levels.

## Overview
The color assignment step includes:

- Data Validation - Validate required cell type columns exist in AnnData object
- Color Mapping - Map ABC atlas colors to class, subclass, supertype, and cluster levels
- Dictionary Storage - Store color mappings in AnnData.uns
- Output Generation - Save annotated data with complete color information

## Input Files

- `*{mapping_type}_combined.h5ad` - Combined mapping results from previous processing steps 
- `*annotation.csv` - Contains standardized ABC color mappings for all taxonomic levels
- `params.json` - Configuration file with specimen and mapping parameters
  
## Output Files

- `{specimen}_{dataset_id}_{mapping_acronym}_{mapping_type}_combined.h5ad` - Data with color assignments saved to results/whole_dataset/
- Ex: `mouse_638850_mmc_both_combined.h5ad`
  
### Added Metadata Columns
The color assignment adds multiple color columns to adata.obs with the format `{mapping_type}_{mapping_acronym}_{level}_color` for each level (class, subclass, supertype, and cluster).

### Dictionary Storage in adata.uns:

- `{mapping_type}_{mapping_acronym}_class_colors` - Class name to color mapping dictionary
- `{mapping_type}_{mapping_acronym}_subclass_colors` - Subclass name to color mapping dictionary

## Configuration Parameters

    {
    "mapping_params": {
        "add_colors_bool": "True",
        "mapping_type": "hrc",
        "mapping_acronym": "mmc"},
    "metadata": {
        "specimen": "mouse",
        "dataset_id": "638850"}
    }
    
### Parameter Descriptions

- `add_colors`: String boolean ("True" or "False") to add/skip color mappings
- `mapping_type`: Type of mapping to perform
  - `"flat"`: Flat mapping only
  - `"hrc"`: Hierarchical mapping only 
  - `"both"`: Run both flat and hierarchical mapping, combine results
- `mapping_acronym`: Short identifier for metadata columns (e.g., "mmc")
- `specimen`: Dataset species
- `dataset_id`: Dataset ID


