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

- `../data/*/*{mapping_type}*combined.h5ad` - Cell type mapped AnnData file with correlation scores from previous mapping step
- `../data/*params.json` - Configuration file with DoubleMAD parameters

Required Input Columns in AnnData:

- `basic_doublets_qc_passed` - Boolean column indicating cells that passed initial QC (added during QC Filtering step)
-  MapMyCells results for each taxonomy level

## Output File
`../results/whole_dataset/{specimen}_{dataset_id}_{mapping_type}_{mapping_acronym}_combined_doublemad.h5ad` - Updated AnnData file with DoubleMAD metrics

### Added Metadata Columns:

- `{mapping_type}_{mapping_acronym}_{level}_thr` - DoubleMAD threshold for cluster and supertype level
- `{mapping_type}_{mapping_acronym}_{level}_thr_criteria` - `Passed` or `Failed` based on threshold comparison for cluster and supertype level
- `{mapping_type}_{mapping_acronym}_is_bimodal_supertype`, `{mapping_type}_{mapping_acronym}_is_bimodal_cluster` - Boolean indicating whether supertype/cluster average correlation distribution is bimodal
- `{mapping_type}_{mapping_acronym}_qc_passed` - Boolean indicating if cell passes DoubleMAD threshold


## Configuration Parameters
The DoubleMAD parameters are specified in `params.json`:

    "doublemad_params": {
        "run_doublemad": 1,
        "doublemad_multiplier": 3
    }
  
### Parameter Descriptions

- `run_doublemad`: Set to 1 to perform DoubleMAD calculation, or 0 to skip this step. 
- `doublemad_multiplier`: Multiplier for DoubleMAD threshold calculation
