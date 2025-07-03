# Leiden Clustering
---
This module performs Leiden clustering using RAPIDS single-cell library with STAligner embeddings for neighbor graph construction.

## Overview

The Leiden clustering step includes:

- Neighbor Graph Construction - Build k-nearest neighbor graph using spatial embeddings
- Leiden Clustering - Apply Leiden algorithm with one or more specified resolution(s)
- UMAP Generation - Create 2D embedding for visualization
- Results Saving - Save data with cluster assignments

## Input Files

- `*staligner*.h5ad` - AnnData file with STAligner embeddings 
- `params.json` - Configuration file with clustering parameters
- `res_params/params_{resolution}.json` - Resolution-specific parameter file

## Output Files

- `{specimen}_{dataset_id}_res_{resolution}_clustered.h5ad` - Clustered AnnData file saved to `results/clustered/`

### Added Metadata Columns

- `leiden_res_{resolution}_knn_{n_neighbors}`: Leiden cluster assignments
- `X_umap`: UMAP coordinates stored in `.obsm`
- Neighbors graph stored in `.obsp`

## Configuration Parameters

The clustering parameters are specified in configuration files:

    {
    "domain_detection_params": {
        "n_neighbors": 8,
        "cluster_key": "STAligner"
    },
    "metadata": {
        "specimen": "mouse",
        "dataset_id": "720609"
    }

**Resolution Parameters:**

    {
        "resolution": "1.2"
    }

### Parameter Descriptions

**Domain Detection Parameters:**
- `n_neighbors`: Number of nearest neighbors for graph construction 
- `cluster_key`: Key name for spatial embeddings in `.obsm` (e.g., "STAligner", "STAGATE")

**Resolution Parameter:**
- `resolution`: Leiden clustering resolution controlling cluster granularity

**Metadata Parameters:**
- `specimen`: Species name for output filename
- `dataset_id`: Dataset identifier for output filename
