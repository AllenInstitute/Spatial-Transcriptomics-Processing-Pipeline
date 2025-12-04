# Spatial Transcriptomics Data Processing Pipeline
---
This repository contains a comprehensive processing pipeline for spatial transcriptomics data analysis.

This pipeline was built and deployed on Code Ocean, a cloud-based computational research platform. The pipeline leverages Code Ocean's containerized environment to ensure reproducible results across different computing environments.

Code Ocean documentation: https://docs.codeocean.com/user-guide 

## QC & Mapping Overview

The processing section of pipeline consists of the following sequential steps:

### [Step 1: QC Filtering & Doublet Detection](./docs/processing_docs/1_qc_filtering.md)
Quality control filtering and doublet detection with SOLO (Semi-supervised Outlier Detection).

### [Step 2: Cell Type Mapping](./docs/processing_docs/2_mapping.md)
Perform MapMyCells cell type mapping. 

### [Step 3: Combine Sections](./docs/processing_docs/3_combine_sections.md)
Aggregate individual section-level AnnData files into a single combined dataset for whole-dataset analysis.

### [Step 4: Add Cell Type Colors](./docs/processing_docs/4_add_cell_type_colors.md)
Add color mappings for cell type classifications to AnnData objects using the ABC atlas color scheme.

### [Step 5: DoubleMAD Mapping Filtering](./docs/processing_docs/5_doublemad.md)
Perform quality control on cell type mapping results using Double Median Absolute Deviation (DoubleMAD) statistics to identify and filter cells with poor mapping confidence scores.

### [Step 6: Save Processing Results](./docs/processing_docs/6_save_results.md)
Save final processed results from the pipeline and add final QC column.

## Domain Detection Overview

The domain detection section of pipeline consists of the following sequential steps:

### [Step 1: Downsample Spot Table](./docs/domain_detection_docs/1_downsample_spot_table.md)
Bin transcript spots and performs QC filtering.

### [Step 2: Run STAligner](./docs/domain_detection_docs/2_run_STAligner.md)
Perform spatial alignment and integration of multiple tissue sections using STAligner.

### [Step 3: Leiden Clustering](./docs/domain_detection_docs/3_leiden_clustering.md)
Perform Leiden clustering with STAligner embeddings.

### [Step 4: Add Clusters to Cell-By-Gene](./docs/domain_detection_docs/4_add_clusters_cbg.md)
Map cluster assignments from downsampled STAligner gridded data to cell segmentation data.

### [Step 5: Merge All Clusters](./docs/domain_detection_docs/5_merge_clusters.md)
Consolidate cluster assignments to full processed dataset.

## Setup

Running via Code Ocean UI:
1. Create a new Pipeline by cloning this repository 
2. Replace Data Parameters
3. Configure App Panel with your dataset-specific parameters
4. Verify data format matches expected input structure
5. Click "Run with parameters" to run pipeline

Running on your local machine:
1. Click Pipeline -> Export
2. Follow the instructions in REPRODUCING.md

## Configuration

All pipeline parameters are configured in the Create Parameters JSON capsule and centralized in `params.json`. Key parameter categories include:

- **QC Filtering Parameters**
- **Mapping Parameters**
- **Metadata Parameters**
- **Domain Detection Parameters**

## Input Data Format
```
data/
└── section_dir/
    ├── section1.h5ad
    ├── section2.h5ad
    ├── section3.h5ad
    └── ...
...
```
Required columns:
- `x` and `y`: cell centroid coordinates
- `brain_section_barcode`: Section ID
- Index containing unique cell labels (e.g.,`{brain_section_barcode}_SIS_{i}`)

## Output Files
The pipeline generates the following key outputs:
```
results/
├── whole_dataset/
│   ├── {specimen}_{dataset_id}_filtered.h5ad
|   └── {specimen}_{dataset_id}_filtered.csv
└── sections/
    ├── section1_filtered.h5ad
    ├── section2_filtered.h5ad
    └── ...
```
Key output files:
- `{specimen}_{dataset_id}_filtered.h5ad`: Combined, QC-filtered data
- `sectioni_filtered.h5ad`: QC-filtered data split by `brain_section_barcode`
  
## Support

For detailed information about each step, refer to the individual markdown files linked above. Each file contains:
- Detailed methodology description
- Input/output file specifications
- Configuration parameter explanations
- Expected results and metadata columns

We are planning on occasional updating this tool with no fixed schedule. Community involvement is encouraged through both issues and pull requests.
