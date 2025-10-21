# Add Clusters to Cell-By-Gene
This module maps cluster assignments from downsampled STALigner gridded data to cell-by-gene.

## Input Files
- `../data/*/*clustered.h5ad` - Downsampled STAligner dataset with spatial clustering results
- `../data/*/sections/*.h5ad` - Individual section datasets from processing
- `../data/*/params.json` - Configuration file with grid_size parameter

## Output Files
- `../results/sections_{resolution}/{section}_clust.h5ad` - Section datasets with added cluster labels

## Added Metadata Columns
- `leiden_res_{resolution}_knn_{n_neighbors}` - Leiden clustering labels at specified resolution

## Configuration Parameters

The parameters are specified in `params.json`:

    "domain_detection_params": {
        "grid_size": 30
    }

### Parameter Descriptions

- `grid_size`: Size of the grid squares used for spatial binning for STAligner. Defines the spatial resolution for cluster assignment; cells within grid_size/2 distance from a grid center in both x and y directions will be assigned to that grid's cluster. 
