# Combine Sections
---

This module aggregates individual section-level AnnData files into a single combined dataset for whole-dataset analysis. 

## Overview
The combine sections step includes:

- File Discovery - Locate all section-level h5ad files based on mapping type
- Data Concatenation - Combine multiple AnnData objects into single dataset and save

## Input Files

- `*{mapping_type}.h5ad` - Section-level AnnData files from mapping step
- `params.json` - Configuration file with specimen and mapping information

## Output File
- `{specimen}_{dataset_id}_{mapping_acronym}_{mapping_type}_combined.h5ad` - Combined dataset saved to results/whole_dataset/
- Ex: `mouse_638850_mmc_both_combined.h5ad`

## Configuration Parameters
The combine sections step uses parameters from existing configuration file:

    {
    "mapping_params": {
        "mapping_type": "both"
    }, 
    "metadata": {
        "specimen": "mouse",
        "dataset_id": "638850",
    }
    }

### Parameter Descriptions

- `mapping_type`: Type of mapping files to combine
  - `"flat"`: Combine flat mapping results only
  - `"hrc"`: Combine hierarchical mapping results only
  - `"both"`: Combine files containing both mapping types
- `mapping_acronym`: Short identifier used in output filename (e.g., "mmc")
- `specimen`: Species name used in output filename
- `dataset_id`: Dataset identifier used in output filename
