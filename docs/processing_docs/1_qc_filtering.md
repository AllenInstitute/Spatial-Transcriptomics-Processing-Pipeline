# QC Filtering & Doublet Detection
---
This module performs quality control filtering and doublet detection on spatial transcriptomics data using [SOLO (Semi-supervised Outlier Detection)](https://docs.scvi-tools.org/en/stable/user_guide/models/solo.html).

## Overview
The QC filtering and doublet detection step includes:

- Data Loading & Preparation - Load AnnData and calculate QC metrics
- Basic QC Filtering - Apply thresholds and label low-quality cells
- Doublet Detection - Train VAE and SOLO models to identify doublet cells
- Incongruous Gene Pair Analysis - Calculate percentage of gene pairs where 2 genes which are not typically found together, co-occur
- Incongruous Genes Analysis - Compares the expression levels for each gene in an incongruous pair and calculates the perentage of the lower-expressed gene relative to the total number of genes expressed in each cell
- Results Saving - Save filtered data with QC annotations

## Input Files
- `/sections/*.h5ad` - Segmented AnnData file in /data/sections directory
- `inconguent_gene*.csv` - Reference table of incongruous gene pairs (optional)
- `params.json` - Configuration file with filtering parameters

### Required Metadata Columns:
- `x` and `y`: cell centroid coordinates
- `volume`: Cell volume (µm³)
- `brain_section_barcode`: Section ID
- Index containing unique cell labels (e.g.,`{section}_SIS_{i}`) 

## Output Files
`{brain_section_barcode}_filtered.h5ad` - Filtered AnnData file with QC annotations saved to /results/sections/

### Added Metadata Columns:

QC Filter Columns:
- `{parameter}_qc_passed`: Boolean indicating if cell passes individual parameter threshold (n_genes_by_counts, total_counts, and pct_counts_blank)
- `basic_qc_passed`: Boolean indicating if cell passes all basic QC filters
- `doublets_qc_passed`: Boolean indicating if cell is not a doublet
- `basic_doublets_qc_passed`: Boolean indicating if cell passes all QC filters (basic + doublet)

Doublet Detection Columns:
- `doublet`: SOLO doublet prediction score
- `singlet`: SOLO singlet prediction score
- `prediction`: SOLO prediction category ('doublet' or 'singlet')
- `doublet_singlet_score_diff`: Difference between doublet and singlet scores
- `doublet_diff_threshold`: Threshold value used for doublet detection

Incongruous Genes Columns:
- `incongruous_pairs_pct`: Percentage of gene pairs where 2 genes which are not typically found together, co-occur
- `incongruous_genes_pct`: Compares expression levels for each gene in an incongruous pair, percentage of the lower-expressed gene relative to total number of genes expressed in cell
  
## Configuration Parameters
The filtering parameters are specified in `params.json`:

    "filtering_params": {
        "min": {
            "n_genes_by_counts": 6,
            "total_counts": 30,
            "volume": null
        },
        "max": {
            "total_counts": null,
            "pct_counts_blank": 2
        },
        "doublets_cutoff": null,
        "run_incongruous_genes": 1
    }

### Parameter Descriptions
Minimum Thresholds (`min`):

- `n_genes_by_counts`: Minimum number of genes detected per cell (applied to non-blank genes)
- `total_counts`: Minimum total transcript counts per cell (applied to non-blank genes)
- `volume`: Minimum cell volume

Maximum Thresholds (`max`):

- `total_counts`: Maximum total transcript counts per cell (applied to non-blank genes)
- `pct_counts_blank`: Maximum percentage of blank/control transcript counts

`run_incongruous_genes`: 1/0 to enable/disable incongruous genes calculation


