# Add Clusters CBG Pipeline Step
This module maps cluster assignments from downsampled STALigner gridded data to cell segmentation data.

## Input Files
- `*/*clustered.h5ad` - Downsampled STAligner dataset with spatial clustering results
- `*/sections/*.h5ad` - Individual section datasets from processing
- `params.json` - Configuration file with grid_size parameter

## Output Files
- `sections_{resolution}/{section}_clust.h5ad` - Section datasets with added cluster labels, where:
  - `{resolution}` is the clustering resolution extracted from STALigner results
  - `{section}` is the individual section ID

## Added Metadata Columns
- `leiden_res_{resolution}_knn_{n_neighbors}` - Leiden clustering labels at specified resolution

## Configuration Parameters

    "domain_detection_params": {
        "grid_size": 30
    }

### Parameter Descriptions

- `grid_size`: Size of the grid squares used for spatial binning for STAligner. Defines the spatial resolution for cluster assignment - cells within grid_size/2 distance from a grid center in both x and y directions will be assigned to that grid's cluster. Must match the grid size used in the original STALigner clustering step.
