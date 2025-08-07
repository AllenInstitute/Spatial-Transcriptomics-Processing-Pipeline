# DoubleMAD Mapping Filtering
---
This module performs quality control on cell type mapping results using Double Median Absolute Deviation (DoubleMAD) statistics to identify and filter cells with poor mapping confidence scores. It sets dynamic thresholds based on the distribution of correlation scores within each cell type group.

## Overview
The DoubleMAD quality control step includes:

- Data Loading - Load mapped AnnData object and filter for QC-passed cells
- DoubleMAD Calculation - Compute left and right MAD statistics for each level
- Threshold Setting - Set dynamic thresholds
- Bimodal Detection - Identify supertypes with bimodal correlation distributions
- Results Integration - Add threshold and criteria columns to cell metadata

## Input Files

- `*.h5ad` - Cell type mapped AnnData file with correlation scores from previous mapping step
- `params.json` - Configuration file with DoubleMAD parameters

Required Input Columns in AnnData:

- `qc_passed` - Boolean column indicating cells that passed initial QC (added during QC Filtering step)
-  MapMyCells results for each taxonomy level

## Output File
`{specimen}_{dataset_id}_{mapping_type}_{mapping_acronym}_combined_doublemad.h5ad` - Updated AnnData file with DoubleMAD metrics saved to results/whole_dataset/

### Added Metadata Columns:

- `{mapping_type}_{mapping_acronym}_{level}_thr` - DoubleMAD threshold for cluster and supertype level
- `{mapping_type}_{mapping_acronym}_{level}_thr_criteria` - Pass/fail criteria based on threshold comparison for cluster and supertype level
- `is_bimodal_supertype`, `is_bimodal_cluster` - Boolean indicating whether supertype/cluster average correlation distribution is bimodal
- `{mapping_type}_{mapping_acronym}_qc_passed` - Boolean indicating if cell passes DoubleMAD threshold


## Configuration Parameters
The DoubleMAD calculation is controlled by a parameter in `params.json`:

    "doublemad_params": {
        "run_doublemad": "True",
        "doublemad_multiplier": 3
    }
  
### Parameter Descriptions

- `run_doublemad`: String boolean ("True" or "False") to enable/disable DoubleMAD calculation
- `doublemad_multiplier`: Multiplier for DoubleMAD threshold calculation
