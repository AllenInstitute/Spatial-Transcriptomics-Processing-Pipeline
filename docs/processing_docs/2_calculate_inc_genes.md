# Calculate Incongruous Genes
---
This module calculates incongruity metrics for spatial transcriptomics data by analyzing co-expression patterns of gene pairs that should not be expressed together in the same cell.

## Overview
The incongruous genes calculation step includes:

- Data Loading - Load filtered AnnData from previous QC step
- Incongruous Gene Pair Analysis - Calculate percentage of gene pairs where 2 genes which are not typically found together, co-occur
- Incongruous Genes Analysis - Compares the expression levels for each gene in an incongruous pair and calculates the perentage of the lower-expressed gene relative to the total number of genes expressed in each cell
- Results Saving - Save data with incongruity metrics

## Input Files

- `*.h5ad` - Filtered AnnData file from previous QC step
- `inconguent_gene*.csv` - Reference table of incongruous gene pairs
- `params.json` - Configuration file containing `run_incongruous_genes` parameter
  
## Output Files

`{section}_filtered.h5ad` - Updated AnnData file with incongruity metrics saved to results/sections/

### Added Metadata Columns
- `incongruous_pairs_pct`: Percentage of gene pairs where 2 genes which are not typically found together, co-occur
- `incongruous_genes_pct`: Compares expression levels for each gene in an incongruous pair, percentage of the lower-expressed gene relative to total number of genes expressed in cell

## Configuration Parameters
The incongruous genes calculation is controlled by a parameter in `params.json`:

    "filtering_params": {
        "run_incongruous_genes": "True"
    }

### Parameter Descriptions

`run_incongruous_genes`: String boolean ("True" or "False") to enable/disable incongruous genes calculation
