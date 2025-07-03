# Create Parameters JSON
This module creates a JSON parameter file for the spatial transcriptomics processing pipeline. 

#### Filtering Parameters

| Argument | Type | Description |
|----------|------|-------------|
| `--n_genes_lower_thr` | int | Label cells with < n genes |
| `--n_spots_lower_thr` | int | Label cells with < n spots |
| `--n_spots_upper_thr` | int | Label cells with > n spots |
| `--volume_lower_thr` | int | Label cells with < n µm volume |
| `--pct_blanks_upper_thr` | int | Label cells with > n % blanks |
| `--doublets_thr` | str | Set doublets cutoff |
| `--run_incongruous_genes` | str | True to run incongruous genes step, False to skip |

### Mapping Parameters

| Argument | Type | Description |
|----------|------|-------------|
| `--normalization` | str | "raw" or "log2CPM" - normalization type for cell by gene data |
| `--drop_level` | str | Cell type taxonomy level to drop before mapping |
| `--mapping_type` | str | "hrc", "flat", or "both" - type of mapping to run |
| `--bootstrap_iteration` | int | Number of bootstrapping iterations per taxonomy tree node |
| `--bootstrap_factor` | float | Factor for downsampling marker gene population |
| `--n_processors` | int | Number of independent worker processes |
| `--chunk_size` | int | Number of cells per worker process |
| `--n_runners_up` | int | Number of runner-ups to generate |
| `--mapping_acronym` | str | Acronym for mapped column names and file names |
| `--clobber` | bool | True to overwrite existing results |
| `--drop_genes_list` | str | Comma-separated list of genes to drop from mapping |
| `--run_add_colors` | str | True to add cell type colors, False to skip |


### DoubleMAD Filtering Parameters

| Argument | Type | Description |
|----------|------|-------------|
| `--run_doublemad` | str | True to run DoubleMAD step, False to skip |
| `--doublemad_multiplier` | int | Integer multiplier for DoubleMAD threshold |

### Metadata Parameters

| Argument | Type | Description |
|----------|------|-------------|
| `--specimen` | str | Specimen type (e.g., mouse or human) |
| `--dataset_id` | str | Dataset ID |
| `--age` | str | Age for .obs metadata |
| `--sex` | str | Sex for .obs metadata |

### Domain Detection Parameters

| Argument | Type | Description |
|----------|------|-------------|
| `--grid_size` | int | Grid size for adding spatial clusters to cells |
| `--n_neighbors` | int | Number of neighbors for STAligner graph training |
| `--cluster_key` | str | Clustering key name (e.g., STAligner or STAGATE) |
| `--resolutions` | str | Comma-separated list of resolutions |

### Downsample Parameters
| Parameter | Type | Description |
|-----------|------|-------------|
| `--grid_size` | int | Grid size for downsampling |
| `--bucket_name` | str | S3 bucket name for data storage |
| `--object_key_template` | str | Template for S3 object key naming |
| `--modality` | str | Data modality type (e.g., xenium or merscope |
| `--genes_thr` | int | Threshold for downsampled gene filtering |
| `--transcripts_thr` | int | Threshold for donwsampled transcript filtering |
| `--blanks_thr` | int | Threshold for downsampled blanks filtering |

### STAligner Parameters
| Parameter | Type | Description |
|-----------|------|-------------|
| `--specimen` | str | Specimen type (e.g., mouse or human)|
| `--dataset_id` | str | Dataset ID |
| `--n_neighbors` | int | Number of neighbors for graph construction |
| `--reverse` | bool | Reverse orientation flag |

### Cluster Parameters
| Parameter | Type | Description |
|-----------|------|-------------|
| `--n_neighbors` | int | Number of neighbors for clustering |
| `--cluster_key` | str | Key for cluster identification |
| `--dataset_id` | str | Dataset ID |
| `--specimen` | str | Specimen type (e.g., mouse or human) |


## Output Files

The script generates two types of JSON parameter files:

### 1. Main Parameters File
- **Location**: `../results/params/params.json`
- **Content**: Complete parameter configuration organized by category

### 2. Resolution-Specific Files
- **Location**: `../results/res_params/params_{resolution}.json`
- **Content**: Individual parameter files for each resolution specified
- **Purpose**: Enables job splitting by resolution

## JSON Structure

```json
{
    "downsample_params": {
        "grid_size": "int",
        "bucket_name": "str",
        "object_key_template": "str",
        "modality": "str",
        "genes_thr": "int",
        "transcripts_thr": "int",
        "blanks_thr": "int"
    },
    "staligner_params": {
        "specimen": "str",
        "dataset_id": "str",
        "n_neighbors": "int",
        "reverse": "bool"
    },
    "cluster_params": {
        "n_neighbors": "int",
        "cluster_key": "str",
        "dataset_id": "str",
        "specimen": "str"
    },
    "domain_detection_params": {
        "grid_size": "int",
        "n_neighbors": "int",
        "cluster_key": "str"
    },
    "filtering_params": {
        "min": {
            "n_genes_by_counts": "int",
            "total_counts": "int",
            "volume": "int"
        },
        "max": {
            "total_counts": "int",
            "pct_counts_blank": "int"
        },
        "doublets_cutoff": "str",
        "run_incongruous_genes": "str"
    },
    "mapping_params": {
        "normalization": "str",
        "drop_level": "str",
        "mapping_type": "str",
        "bootstrap_iteration": "int",
        "bootstrap_factor": "float",
        "n_runner_ups": "int",
        "n_processors": "int",
        "chunk_size": "int",
        "clobber": "bool",
        "mapping_acronym": "str",
        "drop_genes_list": "str"
    },
    "doublemad_params": {
        "run_doublemad": "str",
        "doublemad_multiplier": "int"
    },
    "metadata": {
        "specimen": "str",
        "dataset_id": "str",
        "age": "str",
        "sex": "str"
    }
}
```
