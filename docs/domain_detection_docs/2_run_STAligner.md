# Run STAligner
---
This module performs spatial alignment and integration of multiple tissue sections using [STAligner](https://github.com/zhoux85/STAligner), a deep learning framework for spatial transcriptomics data integration.

## Overview
The STAligner step includes:
- Data Loading & Preparation - Load gridded h5ad files and apply quality control filtering
- Section Ordering - Determine anterior-posterior order from CSV or sort by barcode
- Spatial Network Construction - Build KNN spatial networks for each section
- Data Preprocessing - Normalize and log-transform
- Multi-Section Integration - Train STAligner model to align sections sequentially
- Results Saving - Save integrated data with aligned embeddings

## Input Files
- `../data/*downsampled*/{section_id}*.h5ad` - Gridded AnnData files from downsample spot table step
- `../data/*/*.csv` - Optional CSV file with section ordering information (columns: dataset_id, barcode, AP_order)

### Required Metadata Columns:
- `basic_qc_passed`: Boolean indicating if all QC filters passed
- `.var['blank']: Indicates blank genes; entries must be labeled 'blank'.

### Section Order CSV Columns:
- `dataset_id`: Dataset ID
- `barcode`: Section IDs
- `AP_order`: Specifies the position of each section along the anterior-to-posterior axis, using values from 1 (most anterior) to n_sections (most posterior).
  
## Output Files
`../results/domain_detection/{specimen}_{dataset_id}_staligner_knn_{n_neighbors}.h5ad` - Integrated AnnData file with STAligner embeddings and alignments saved to `results/domain_detection/`

### Added Metadata Columns:

- `slice_name`: Section ID 
- `batch_name`: Categorical batch identifier (same as slice_name)
- `obsm['STAligner']`: Low-dimensional embeddings from STAligner integration
- `obsm['STAGATE']`: Low-dimensional spatially-aware embeddings for each slice
- `uns['adj']`: Spatial adjacency matrices for each section
- `var['highly_variable']`: Boolean indicating highly variable genes used for integration

## Configuration Parameters
The STAligner parameters are specified in `params.json`:

    {
    "metadata": {
        "specimen": "mouse",
        "dataset_id": "720609"},
    "staligner_params": {
        "n_neighbors": 8,
        "reverse": 1}
    }

## Parameter Descriptions
- `specimen`: Species type for output file naming
- `dataset_id`: Dataset identifier used for output file naming
- `n_neighbors`: Number of neighbors for KNN spatial network construction
- `reverse`: Controls section ordering direction. Set to 1 to sort barcodes in descending order, or 0 for ascending order, when no AP_order CSV is available.

