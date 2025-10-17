# Merge All Cluster Columns

This module consolidates cluster assignments to full processed dataset. 

## Overview
- Merges cluster labels from processed sections back into the complete filtered dataset
- Dynamically loads clustering results from multiple resolution parameters
- Outputs both consolidated whole dataset and individual section files

## Input Files
- `../data/*/whole_dataset/*{dataset_id}*.h5ad` - Original filtered whole dataset (from Save Results step)
- `../data/*/sections_{resolution}/*` - Section files with cluster annotations from previous domain detection steps
- `../data/res_params/params_{resolution}.json` - JSON parameter files containing resolution values used for clustering
- `../data/*/params.json` - Configuration file

## Output Files
- `../results/whole_dataset/{specimen}_{dataset_id}_filtered.h5ad` - Complete dataset with merged cluster annotations
- `../results/whole_dataset/{specimen}_{dataset_id}_filtered.csv` - Observation metadata in CSV format
- `../results/sections/{section}_filtered.h5ad` - Individual section files with cluster annotations

## Added Metadata Columns
- `leiden_res_{resolution}_knn_{n_neighbors}` - Leiden clustering labels for each resolution
  - Multiple columns added based on available resolution parameters
- `AP_order` - Anatomical position ordering (integer values in ascending order)
  - Only added if not already present in the dataset

## Configuration Parameters

The parameters are specified in `params.json`:

    {
    "metadata": {
        "specimen": "mouse",
        "dataset_id": "720609"}
    }

The resolution parameters are specified in `params_{resolution}.json`:

  {
    "resolution": "0.8"
  }

