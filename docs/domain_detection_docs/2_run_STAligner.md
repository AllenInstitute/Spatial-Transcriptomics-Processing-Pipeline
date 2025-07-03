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
- `{section_id}*.h5ad` - Gridded AnnData files from downsample spot table step
- `*barcodes*.csv` - Optional CSV file with section ordering information (columns: dataset_id, barcode, AP_order)

## Output Files
`{specimen}_{dataset_id}_staligner_knn_{n_neighbors}.h5ad` - Integrated AnnData file with STAligner embeddings and alignments saved to `results/domain_detection/`

### Added Metadata Columns:

- `slice_name`: Section ID 
- `batch_name`: Categorical batch identifier (same as slice_name)
- `obsm['STAligner']`: Low-dimensional embeddings from STAligner integration
- `obsm['STAGATE']`: 
- `uns['adj']`: Spatial adjacency matrices for each section
- `var['highly_variable']`: Boolean indicating highly variable genes used for integration

## Configuration Parameters
The STAligner parameters are listed in `params.json`:

    "staligner_params": {
        "specimen": "mouse",
        "dataset_id": "720609",
        "n_neighbors": 8,
        "reverse": null
    }

## Parameter Descriptions
- `specimen`: Species type for output file naming
- `dataset_id`: Dataset identifier used for output file naming
- `n_neighbors`: Number of neighbors for KNN spatial network construction
- `reverse`: Controls section ordering direction. Set to 'True' to reverse numerical ordering of barcodes when no AP_order CSV is provided

