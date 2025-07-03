# Save Results
---
This module consolidates and saves final processed results from the pipeline.

## Overview
The save results step includes:

- Data Loading - Load processed AnnData object from previous pipeline steps
- QC Consolidation - Combine multiple QC criteria into final pass/fail status
- Metadata Integration - Add specimen, dataset, age, and sex information to cell observations
- Data Layer Creation - Generate raw and log2-transformed expression layers
- Output Generation - Save whole dataset and individual section files

## Input Files

- `*{mapping_type}*.h5ad` - Processed AnnData file from previous pipeline steps
- `params.json` - Configuration file with metadata information

### Required Input Columns in AnnData:

- `production_cell_id` - Cell IDs for index setting
- `*qc_passed*` - QC columns from previous pipeline steps
- `center_x`, `center_y` - Spatial coordinates for cells
- `section` - Section IDs for splitting data

## Output Files

- `whole_dataset/{specimen}_{dataset_id}_filtered.h5ad` - Complete filtered dataset
- `sections/{section}_filtered.h5ad` - Individual section files

### Directory Structure:

    results/
    ├── whole_dataset/
    │   └── {specimen}_{dataset_id}_filtered.h5ad
    └── sections/
        ├── section1_filtered.h5ad
        ├── section2_filtered.h5ad
        └── ...

### Added Metadata Columns:

adata.obs:
- `final_qc_passed` - Boolean indicating cells passing all QC criteria (genes, transcripts, blanks, doublets, & DoubleMAD)
- `production_cell_id` - Cell IDs (used as index)
- `specimen` - Species name
- `dataset_id` - Dataset identifier
- `age` - Age information (if provided)
- `sex` - Sex information (if provided)

adata.layers:
- `raw` - Original expression matrix (copy of adata.X)
- `log2` - Log2-transformed expression: log2(X + 1)

adata.obsm:
- `spatial` - 2D array of spatial coordinates [`center_x`, `center_y`]

## Configuration Parameters
The save results function uses parameters from existing configuration file:

    {
    "mapping_params": {
        "mapping_type": "both"
    }, 
    "metadata": {
        "specimen": "mouse",
        "dataset_id": "720609",
        "age": "P0",
        "sex": "F"
    }
    }
  
### Parameter Descriptions

- `specimen`: Species name added to obs metadata
- `dataset_id`: Dataset ID added to obs metadata
- `age`: Age information added to obs metadata (optional)
- `sex`: Sex information added to obs metadata (optional)
- `mapping_type`: Used to locate input files via glob pattern matching (file pattern: `*{mapping_type}*.h5ad`)
