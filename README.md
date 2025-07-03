# Spatial Transcriptomics Data Processing Pipeline
---
This repository contains a comprehensive processing pipeline for spatial transcriptomics data analysis.

This analysis pipeline was built and deployed on Code Ocean, a cloud-based computational research platform. The pipeline leverages Code Ocean's containerized environment to ensure reproducible results across different computing environments.

Code Ocean documentation: https://docs.codeocean.com/user-guide 

## QC & Mapping Pipeline Overview

The processing pipeline consists of the following sequential steps:

### [Step 1: QC Filtering & Doublet Detection](./docs/processing_docs/1_qc_filtering.md)
Quality control filtering and doublet detection using basic thresholding and SOLO (Semi-supervised Outlier Detection).

### [Step 2: Calculate Incongruous Genes](./docs/processing_docs/2_calculate_inc_genes.md)
Analyze co-expression patterns of gene pairs that should not be expressed together in the same cell.

### [Step 3: Cell Type Mapping](./docs/processing_docs/3_mapping.md)
Perform MapMyCells cell type mapping. 

### [Step 4: Combine Sections](./docs/processing_docs/4_combine_sections.md)
Aggregate individual section-level AnnData files into a single combined dataset for whole-dataset analysis.

### [Step 5: Add Cell Type Colors](./docs/processing_docs/5_add_cell_type_colors.md)
Add color mappings for cell type classifications to AnnData objects using the ABC atlas color scheme.

### [Step 6: DoubleMAD Mapping Filtering](./docs/processing_docs/6_doublemad.md)
Perform quality control on cell type mapping results using Double Median Absolute Deviation (DoubleMAD) statistics to identify and filter cells with poor mapping confidence scores.

### [Step 7: Save Results](./docs/processing_docs/7_save_results.md)
Save final processed results from the pipeline.

## Domain Detection Pipeline Overview
### [Step 1: Downsample Spot Table](./docs/domain_detection_docs/1_downsample_spot_table.md)
Bin transcript spots and performs QC filtering.

### [Step 2: Run STAligner](./docs/domain_detection_docs/2_run_STAligner.md)
Perform spatial alignment and integration of multiple tissue sections using STAligner.

### [Step 3: Leiden Clustering](./docs/domain_detection_docs/3_leiden_clustering.md)
Perform Leiden clustering using RAPIDS single-cell library with STAligner embeddings.

### [Step 4: Add Clusters to Cells](./docs/domain_detection_docs/4_add_clusters_cbg.md)
Map cluster assignments from downsampled STALigner gridded data to cell segmentation data.

### [Step 5: Merge All Clusters](./docs/domain_detection_docs/5_merge_clusters.md)
Consolidate cluster assignments to full processed dataset.

## Quick Start

1. **Configuration**: Update App Panel with your parameters
2. **Execution**: Click Run with parameters to run each step sequentially 
3. **Output**: Each step generates intermediate files for the next step

## Pipeline Options:
1. Pipeline with Domain Detection
2. Pipeline without Domain Detection

## Running the Pipeline

- The pipeline can be executed directly within Code Ocean through the web interface or via the Code Ocean API. All dependencies are pre-installed in the containerized environment, eliminating setup complexity.
- Each step can be run independently if intermediate files are available.
- This workflow can be run on one or more sections.
  
## Configuration

All pipeline parameters are centralized in `params.json`. Key parameter categories include:

- **Filtering Parameters**
- **Mapping Parameters**
- **DoubleMAD Parameters**
- **Metadata Parameters**
- **Domain Detection Parameters**

## Support

For detailed information about each step, refer to the individual markdown files linked above. Each file contains:
- Detailed methodology description
- Input/output file specifications
- Configuration parameter explanations
- Expected results and metadata columns
