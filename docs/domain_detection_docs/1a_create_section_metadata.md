# Section Metadata Generation
---
This module generates individual section metadata files from barcode CSV data to dispatch jobs for downstream downsampling.

## Overview
The section metadata generation step includes:
- Barcode Data Loading - Read barcode CSV file containing dataset information
- Dataset Filtering - Filter barcode data for specific dataset ID
- Metadata Splitting - Split each section into separate JSON files for parallelization
- File Validation - Ensure all sections have corresponding metadata files

## Input Files
- `{dataset}_barcode.csv` - Barcode CSV file containing section metadata with columns:
  - `barcode`: Section barcode identifier
  - `dataset_id`: Dataset identifier
  - `region`: region folder in S3 bucket if applicable
  - `experiment_id`: Experiment ID folder in S3 bucket

## Output Files
- `{barcode}_section_metadata.json` - Individual section metadata JSON files
  - One file per section/barcode
  - Contains all metadata fields from the barcode CSV row

### Generated Metadata Fields:
- `barcode`: Section barcode identifier
- `dataset_id`: Dataset identifier
- `region`: Brain region or tissue section
- `experiment_id`: Experiment identifier
- Additional fields from barcode CSV as available

## Configuration Parameters
The metadata parameters are configured in `params.json`:

  "metadata": {
      "dataset_id": "720609"
  }

### Parameter Descriptions
- `dataset_id`: Dataset ID to filter barcode data
