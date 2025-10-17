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
- Barcode CSV file containing section metadata with columns:
  - `barcode`: Section barcode ID
  - `dataset_id`: Dataset ID
  - `region`: Region folder in S3 bucket if applicable
  - `experiment_id`: Experiment ID folder in S3 bucket
  - `s3_bucket` (optional): S3 bucket to read transcripts file. Use if sections are stored across different S3 buckets. Otherwise, reads from the App Panel S3 bucket parameter which applies to all sections.
  - `s3_key` (optional): S3 key to read transcripts file. Use if S3 locations for each section follow different naming patterns or directory structures. Otherwise, reads from the App Panel S3 key parameter which applies to all sections.

## Output Files
- `{barcode}_section_metadata.json` - Individual section metadata JSON files
  - One file per section
  - Contains all metadata fields from the barcode CSV row

## Configuration Parameters
The metadata parameters are configured in `params.json`:

    "metadata": {
        "dataset_id": "720609"
    }

### Parameter Descriptions
- `dataset_id`: Dataset ID to filter barcode data
