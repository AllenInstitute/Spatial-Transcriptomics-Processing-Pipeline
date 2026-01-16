#!/usr/bin/env nextflow
// hash:sha256:da31201c6144caa2f8bc3647eadeac8bd1db2e9349af4d80bda86a2675188920

// capsule - Create Parameters JSON Full Pipeline
process capsule_create_parameters_json_full_pipeline_21 {
	tag 'capsule-1710219'
	container "$REGISTRY_HOST/published/e4dec6b2-35fc-43ea-b344-a9994fba770d:v4"

	cpus 2
	memory '0 GB'

	publishDir "$RESULTS_PATH/params", saveAs: { filename -> filename.matches("capsule/results/params/.*") ? new File(filename).getName() : null }

	output:
	path 'capsule/results/params/*', emit: to_capsule_qc_filtering_doublet_detection_11_3
	path 'capsule/results/params/*', emit: to_capsule_cell_type_mapping_14_6
	path 'capsule/results/params/*', emit: to_capsule_add_cell_type_colors_16_8
	path 'capsule/results/params/*', emit: to_capsule_combine_sections_17_10
	path 'capsule/results/params/*', emit: to_capsule_save_processing_results_18_12
	path 'capsule/results/params/*', emit: to_capsule_doublemad_mapping_filtering_20_14
	path 'capsule/results/params/*'
	path 'capsule/results/res_params/*', emit: to_capsule_leiden_clustering_rapids_23_17
	path 'capsule/results/params/*', emit: to_capsule_leiden_clustering_rapids_23_18
	path 'capsule/results/params/*', emit: to_capsule_add_cluster_labels_to_cells_24_19
	path 'capsule/results/params/*', emit: to_capsule_merge_clusters_25_24
	path 'capsule/results/res_params/*', emit: to_capsule_merge_clusters_25_25
	path 'capsule/results/params/*', emit: to_capsule_run_staligner_26_28
	path 'capsule/results/params/*', emit: to_capsule_downsample_spot_table_27_30
	path 'capsule/results/params/*', emit: to_capsule_dispatch_jobs_28_32

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=e4dec6b2-35fc-43ea-b344-a9994fba770d
	export CO_CPUS=2
	export CO_MEMORY=0

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1710219.git" capsule-repo
	else
		git -c credential.helper= clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1710219.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_create_parameters_json_full_pipeline_21_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Dispatch Jobs
process capsule_dispatch_jobs_28 {
	tag 'capsule-8473949'
	container "$REGISTRY_HOST/published/a81edc3a-4e8b-487a-80ec-8c3b3fca92a7:v3"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/barcodes_csv'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_downsample_spot_table_27_29

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a81edc3a-4e8b-487a-80ec-8c3b3fca92a7
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8473949.git" capsule-repo
	else
		git -c credential.helper= clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8473949.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - QC Filtering & Doublet Detection
process capsule_qc_filtering_doublet_detection_11 {
	tag 'capsule-0022544'
	container "$REGISTRY_HOST/published/1e4a1b6e-a690-4c20-809a-f5def0dbaac2:v5"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/incongruous_genes'
	path 'capsule/data/segmented_data/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_cell_type_mapping_14_5

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1e4a1b6e-a690-4c20-809a-f5def0dbaac2
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0022544.git" capsule-repo
	else
		git -c credential.helper= clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0022544.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Cell Type Mapping
process capsule_cell_type_mapping_14 {
	tag 'capsule-2601578'
	container "$REGISTRY_HOST/published/55150af8-b031-419d-aa7c-84a0fcc17136:v3"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/mapping_files'
	path 'capsule/data/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/mapping_results/*.h5ad', emit: to_capsule_combine_sections_17_11

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=55150af8-b031-419d-aa7c-84a0fcc17136
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2601578.git" capsule-repo
	else
		git -c credential.helper= clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2601578.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Downsample Spot Table
process capsule_downsample_spot_table_27 {
	tag 'capsule-6366717'
	container "$REGISTRY_HOST/published/32dae177-f153-4aa3-aad8-aecec7c8c0a5:v3"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/section_metadata/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/downsampled/*', emit: to_capsule_run_staligner_26_27

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=32dae177-f153-4aa3-aad8-aecec7c8c0a5
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6366717.git" capsule-repo
	else
		git -c credential.helper= clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6366717.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Combine Sections
process capsule_combine_sections_17 {
	tag 'capsule-2475763'
	container "$REGISTRY_HOST/published/15ad4435-978d-459b-a609-a07c13363adb:v2"

	cpus 32
	memory '120 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/mapping_results/sections/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_cell_type_colors_16_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=15ad4435-978d-459b-a609-a07c13363adb
	export CO_CPUS=32
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2475763.git" capsule-repo
	else
		git -c credential.helper= clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2475763.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Run STAligner
process capsule_run_staligner_26 {
	tag 'capsule-9167853'
	container "$REGISTRY_HOST/published/827e81af-5645-42b8-af98-36c4f453fcf3:v4"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/barcodes_csv'
	path 'capsule/data/downsampled/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_leiden_clustering_rapids_23_16

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=827e81af-5645-42b8-af98-36c4f453fcf3
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9167853.git" capsule-repo
	else
		git -c credential.helper= clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9167853.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Cell Type Colors
process capsule_add_cell_type_colors_16 {
	tag 'capsule-9455197'
	container "$REGISTRY_HOST/published/d0406dbe-3873-4f8a-be1d-e7d2bc67a65c:v4"

	cpus 32
	memory '120 GB'

	input:
	path 'capsule/data/cell_type_colors/'
	path 'capsule/data/params/'
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_doublemad_mapping_filtering_20_15

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=d0406dbe-3873-4f8a-be1d-e7d2bc67a65c
	export CO_CPUS=32
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9455197.git" capsule-repo
	else
		git -c credential.helper= clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9455197.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Leiden Clustering - RAPIDS
process capsule_leiden_clustering_rapids_23 {
	tag 'capsule-2535964'
	container "$REGISTRY_HOST/published/41eb134b-3949-48a2-949b-18b016715656:v4"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/'
	path 'capsule/data/res_params/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_cluster_labels_to_cells_24_21

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=41eb134b-3949-48a2-949b-18b016715656
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2535964.git" capsule-repo
	else
		git -c credential.helper= clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2535964.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Mapping Filtering
process capsule_doublemad_mapping_filtering_20 {
	tag 'capsule-7462997'
	container "$REGISTRY_HOST/published/b832ab1b-afd8-4e50-974e-49a8373054e0:v5"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/'

	output:
	path 'capsule/results/*/*', emit: to_capsule_save_processing_results_18_13

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b832ab1b-afd8-4e50-974e-49a8373054e0
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7462997.git" capsule-repo
	else
		git -c credential.helper= clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7462997.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Save Processing Results
process capsule_save_processing_results_18 {
	tag 'capsule-1191238'
	container "$REGISTRY_HOST/published/014e682e-513f-4a62-a139-d6563efccdf9:v3"

	cpus 32
	memory '120 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/*/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_cluster_labels_to_cells_24_20
	path 'capsule/results/*', emit: to_capsule_merge_clusters_25_23

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=014e682e-513f-4a62-a139-d6563efccdf9
	export CO_CPUS=32
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1191238.git" capsule-repo
	else
		git -c credential.helper= clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1191238.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Cluster Labels to Cells
process capsule_add_cluster_labels_to_cells_24 {
	tag 'capsule-7143267'
	container "$REGISTRY_HOST/published/9df4783c-c9fb-4705-859e-26d24fd784f4:v3"

	cpus 32
	memory '120 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/data_dir/'
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_merge_clusters_25_22

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9df4783c-c9fb-4705-859e-26d24fd784f4
	export CO_CPUS=32
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7143267.git" capsule-repo
	else
		git -c credential.helper= clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7143267.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Merge Clusters
process capsule_merge_clusters_25 {
	tag 'capsule-7874811'
	container "$REGISTRY_HOST/published/f976ba49-9d0f-4769-aec1-693173e2e571:v3"

	cpus 32
	memory '240 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/data_dir/'
	path 'capsule/data/data_dir/'
	path 'capsule/data/params/'
	path 'capsule/data/res_params/'

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=f976ba49-9d0f-4769-aec1-693173e2e571
	export CO_CPUS=32
	export CO_MEMORY=257698037760

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git -c credential.helper= clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7874811.git" capsule-repo
	else
		git -c credential.helper= clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7874811.git" capsule-repo
	fi
	mv capsule-repo/code capsule/code && ln -s \$PWD/capsule/code /code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

params.incongruous_genes_url = 's3://allen-paper-supplements/kunst_preprint_2026/incongruous_genes'
params.segmented_data_url = 's3://allen-paper-supplements/kunst_preprint_2026/segmented_data'
params.mapping_files_url = 's3://allen-paper-supplements/kunst_preprint_2026/mapping_files'
params.cell_type_colors_url = 's3://allen-paper-supplements/kunst_preprint_2026/cell_type_colors'
params.barcodes_csv_url = 's3://allen-paper-supplements/kunst_preprint_2026/barcodes_csv'

workflow {
	// input data
	incongruous_genes_to_qc_filtering_doublet_detection_1 = Channel.fromPath(params.incongruous_genes_url + "/", type: 'any')
	segmented_data_to_qc_filtering_doublet_detection_2 = Channel.fromPath(params.segmented_data_url + "/*", type: 'any')
	mapping_files_to_cell_type_mapping_4 = Channel.fromPath(params.mapping_files_url + "/", type: 'any')
	cell_type_colors_to_add_cell_type_colors_7 = Channel.fromPath(params.cell_type_colors_url + "/*", type: 'any')
	barcodes_csv_to_run_staligner_26 = Channel.fromPath(params.barcodes_csv_url + "/", type: 'any')
	barcodes_csv_to_dispatch_jobs_31 = Channel.fromPath(params.barcodes_csv_url + "/", type: 'any')

	// run processes
	capsule_create_parameters_json_full_pipeline_21()
	capsule_dispatch_jobs_28(barcodes_csv_to_dispatch_jobs_31.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_dispatch_jobs_28_32.collect())
	capsule_qc_filtering_doublet_detection_11(incongruous_genes_to_qc_filtering_doublet_detection_1.collect(), segmented_data_to_qc_filtering_doublet_detection_2, capsule_create_parameters_json_full_pipeline_21.out.to_capsule_qc_filtering_doublet_detection_11_3.collect())
	capsule_cell_type_mapping_14(mapping_files_to_cell_type_mapping_4.collect(), capsule_qc_filtering_doublet_detection_11.out.to_capsule_cell_type_mapping_14_5, capsule_create_parameters_json_full_pipeline_21.out.to_capsule_cell_type_mapping_14_6.collect())
	capsule_downsample_spot_table_27(capsule_dispatch_jobs_28.out.to_capsule_downsample_spot_table_27_29.flatten(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_downsample_spot_table_27_30.collect())
	capsule_combine_sections_17(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_combine_sections_17_10.collect(), capsule_cell_type_mapping_14.out.to_capsule_combine_sections_17_11.collect())
	capsule_run_staligner_26(barcodes_csv_to_run_staligner_26.collect(), capsule_downsample_spot_table_27.out.to_capsule_run_staligner_26_27.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_run_staligner_26_28.collect())
	capsule_add_cell_type_colors_16(cell_type_colors_to_add_cell_type_colors_7, capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_cell_type_colors_16_8.collect(), capsule_combine_sections_17.out.to_capsule_add_cell_type_colors_16_9)
	capsule_leiden_clustering_rapids_23(capsule_run_staligner_26.out.to_capsule_leiden_clustering_rapids_23_16.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_leiden_clustering_rapids_23_17.flatten(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_leiden_clustering_rapids_23_18.collect())
	capsule_doublemad_mapping_filtering_20(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_doublemad_mapping_filtering_20_14.collect(), capsule_add_cell_type_colors_16.out.to_capsule_doublemad_mapping_filtering_20_15)
	capsule_save_processing_results_18(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_save_processing_results_18_12.collect(), capsule_doublemad_mapping_filtering_20.out.to_capsule_save_processing_results_18_13.collect())
	capsule_add_cluster_labels_to_cells_24(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_cluster_labels_to_cells_24_19.collect(), capsule_save_processing_results_18.out.to_capsule_add_cluster_labels_to_cells_24_20.collect(), capsule_leiden_clustering_rapids_23.out.to_capsule_add_cluster_labels_to_cells_24_21)
	capsule_merge_clusters_25(capsule_add_cluster_labels_to_cells_24.out.to_capsule_merge_clusters_25_22.collect(), capsule_save_processing_results_18.out.to_capsule_merge_clusters_25_23.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_merge_clusters_25_24.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_merge_clusters_25_25.collect())
}
