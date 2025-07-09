# QC Filtering & Doublet Detection
---
This module performs quality control filtering and doublet detection on spatial transcriptomics data using [SOLO (Semi-supervised Outlier Detection)](https://docs.scvi-tools.org/en/stable/user_guide/models/solo.html).

## Overview
The QC filtering and doublet detection step includes:

- Data Loading & Preparation - Load AnnData and calculate QC metrics
- Basic QC Filtering - Apply thresholds and label low-quality cells
- Doublet Detection - Train VAE and SOLO models to identify doublet cells
- Results Saving - Save filtered data with QC annotations

## Input Files
- `*_pre.h5ad` - Segmented AnnData file
- `params.json` - Configuration file with filtering parameters

### Required Metadata Columns:
- `center_x` and `center_y`: cell centroid coordinates
- `volume`: Cell volume (in microns)
- `section`: Section ID
- `production_cell_id`: Unique cell ID as index (e.g.,`{section}_CP_{i}`) 

## Output Files
`{section}_filtered.h5ad` - Filtered AnnData file with QC annotations saved to results/sections/

### Added Metadata Columns:

QC Filter Columns:
- `{parameter}_qc_passed`: Boolean indicating if cell passes individual parameter threshold (n_genes_by_counts, total_counts, and pct_counts_blank)
- `basic_qc_passed`: Boolean indicating if cell passes all basic QC filters
- `doublets_qc_passed`: Boolean indicating if cell is not a doublet
- `qc_passed`: Boolean indicating if cell passes all QC filters (basic + doublet)

Doublet Detection Columns:
- `doublet`: SOLO doublet prediction score
- `singlet`: SOLO singlet prediction score
- `prediction`: SOLO prediction category ('doublet' or 'singlet')
- `dif`: Difference between doublet and singlet scores
- `doublets_thr`: Threshold value used for doublet detection
  
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
        "doublets_cutoff": null
    }

### Parameter Descriptions
Minimum Thresholds (`min`):

- `n_genes_by_counts`: Minimum number of genes detected per cell (applied to non-blank genes)
- `total_counts`: Minimum total transcript counts per cell (applied to non-blank genes)
- `volume`: Minimum cell volume

Maximum Thresholds (`max`):

- `total_counts`: Maximum total transcript counts per cell (applied to non-blank genes)
- `pct_counts_blank`: Maximum percentage of blank/control transcript counts


