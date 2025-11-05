#!/usr/bin/env nextflow
// hash:sha256:bc2c799893e5463b1ccbf0283b3990dedb6a003802e4d3a277ece6fca86164a1

// capsule - Create Parameters JSON Full Pipeline
process capsule_create_parameters_json_full_pipeline_21 {
	tag 'capsule-1710219'
	container "$REGISTRY_HOST/published/e4dec6b2-35fc-43ea-b344-a9994fba770d:v2"

	cpus 2
	memory '0 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/params/.*") ? new File(filename).getName() : null }

	output:
	path 'capsule/results/params/*', emit: to_capsule_qc_filtering_doublet_detection_11_1
	path 'capsule/results/params/*', emit: to_capsule_cell_type_mapping_14_4
	path 'capsule/results/params/*', emit: to_capsule_add_cell_type_colors_16_5
	path 'capsule/results/params/*', emit: to_capsule_combine_sections_17_8
	path 'capsule/results/params/*', emit: to_capsule_save_processing_results_18_10
	path 'capsule/results/params/*', emit: to_capsule_doublemad_mapping_filtering_20_12
	path 'capsule/results/params/*'
	path 'capsule/results/res_params/*', emit: to_capsule_leiden_clustering_rapids_23_15
	path 'capsule/results/params/*', emit: to_capsule_leiden_clustering_rapids_23_16
	path 'capsule/results/params/*', emit: to_capsule_add_cluster_labels_to_cells_24_17
	path 'capsule/results/params/*', emit: to_capsule_merge_clusters_25_22
	path 'capsule/results/res_params/*', emit: to_capsule_merge_clusters_25_23
	path 'capsule/results/params/*', emit: to_capsule_run_staligner_26_25
	path 'capsule/results/params/*', emit: to_capsule_downsample_spot_table_27_26
	path 'capsule/results/params/*', emit: to_capsule_dispatch_jobs_28_28

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
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1710219.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1710219.git" capsule-repo
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
	container "$REGISTRY_HOST/published/a81edc3a-4e8b-487a-80ec-8c3b3fca92a7:v2"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_downsample_spot_table_27_27

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

	ln -s "/tmp/data/barcodes_csv" "capsule/data/barcodes_csv" # id: 361c4975-9e72-41fa-af33-837cf648d2d4

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8473949.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8473949.git" capsule-repo
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
	container "$REGISTRY_HOST/published/1e4a1b6e-a690-4c20-809a-f5def0dbaac2:v3"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/params/'
	val path2

	output:
	path 'capsule/results/*', emit: to_capsule_cell_type_mapping_14_3

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
	mkdir -p capsule/data/sections

	ln -s "/tmp/data/incongruous_genes" "capsule/data/incongruous_genes" # id: 5e5ee663-c304-46a9-ba39-c4003cd416a5
	ln -s "/tmp/data/segmented_data/$path2" "capsule/data/sections/$path2" # id: 51ca67b7-1e9b-4dab-8972-6f001bc6cd6c

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0022544.git" capsule-repo
	else
		git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0022544.git" capsule-repo
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
	container "$REGISTRY_HOST/published/55150af8-b031-419d-aa7c-84a0fcc17136:v2"

	cpus 4
	memory '120 GB'

	input:
	path 'capsule/data/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/mapping_results/*.h5ad', emit: to_capsule_combine_sections_17_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=55150af8-b031-419d-aa7c-84a0fcc17136
	export CO_CPUS=4
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/mapping_files" "capsule/data/markers" # id: 4940b042-3c8e-4d28-9701-a087f9de1f3e

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2601578.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2601578.git" capsule-repo
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
	container "$REGISTRY_HOST/published/32dae177-f153-4aa3-aad8-aecec7c8c0a5:v2"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/section_metadata/'

	output:
	path 'capsule/results/downsampled/*', emit: to_capsule_run_staligner_26_24

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
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6366717.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6366717.git" capsule-repo
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
	container "$REGISTRY_HOST/published/15ad4435-978d-459b-a609-a07c13363adb:v1"

	cpus 16
	memory '42 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/mapping_results/sections/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_cell_type_colors_16_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=15ad4435-978d-459b-a609-a07c13363adb
	export CO_CPUS=16
	export CO_MEMORY=45097156608

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2475763.git" capsule-repo
	else
		git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2475763.git" capsule-repo
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
	container "$REGISTRY_HOST/published/827e81af-5645-42b8-af98-36c4f453fcf3:v2"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/downsampled/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_leiden_clustering_rapids_23_14

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

	ln -s "/tmp/data/barcodes_csv" "capsule/data/barcodes" # id: 361c4975-9e72-41fa-af33-837cf648d2d4

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9167853.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9167853.git" capsule-repo
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
	container "$REGISTRY_HOST/published/d0406dbe-3873-4f8a-be1d-e7d2bc67a65c:v2"

	cpus 8
	memory '60 GB'

	input:
	path 'capsule/data/params/'
	val path6
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_doublemad_mapping_filtering_20_13

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=d0406dbe-3873-4f8a-be1d-e7d2bc67a65c
	export CO_CPUS=8
	export CO_MEMORY=64424509440

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path6" "capsule/data/cell_type_colors/$path6" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9455197.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9455197.git" capsule-repo
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
	container "$REGISTRY_HOST/published/41eb134b-3949-48a2-949b-18b016715656:v2"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/'
	path 'capsule/data/res_params/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_cluster_labels_to_cells_24_19

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
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2535964.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2535964.git" capsule-repo
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
	container "$REGISTRY_HOST/published/b832ab1b-afd8-4e50-974e-49a8373054e0:v4"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/'

	output:
	path 'capsule/results/*/*', emit: to_capsule_save_processing_results_18_11

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
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7462997.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7462997.git" capsule-repo
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
	container "$REGISTRY_HOST/published/014e682e-513f-4a62-a139-d6563efccdf9:v2"

	cpus 16
	memory '120 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/*/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_cluster_labels_to_cells_24_18
	path 'capsule/results/*', emit: to_capsule_merge_clusters_25_21

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=014e682e-513f-4a62-a139-d6563efccdf9
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1191238.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1191238.git" capsule-repo
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
	container "$REGISTRY_HOST/published/9df4783c-c9fb-4705-859e-26d24fd784f4:v2"

	cpus 4
	memory '30 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/data_dir/'
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_merge_clusters_25_20

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9df4783c-c9fb-4705-859e-26d24fd784f4
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7143267.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7143267.git" capsule-repo
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
	container "$REGISTRY_HOST/published/f976ba49-9d0f-4769-aec1-693173e2e571:v2"

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
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7874811.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7874811.git" capsule-repo
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

workflow {
	// input data
	segmented_data_to_qc_filtering_doublet_detection_2 = Channel.fromPath("../data/segmented_data/*", type: 'any', relative: true)
	cell_type_colors_to_add_cell_type_colors_6 = Channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)

	// run processes
	capsule_create_parameters_json_full_pipeline_21()
	capsule_dispatch_jobs_28(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_dispatch_jobs_28_28.collect())
	capsule_qc_filtering_doublet_detection_11(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_qc_filtering_doublet_detection_11_1.collect(), segmented_data_to_qc_filtering_doublet_detection_2)
	capsule_cell_type_mapping_14(capsule_qc_filtering_doublet_detection_11.out.to_capsule_cell_type_mapping_14_3, capsule_create_parameters_json_full_pipeline_21.out.to_capsule_cell_type_mapping_14_4.collect())
	capsule_downsample_spot_table_27(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_downsample_spot_table_27_26.collect(), capsule_dispatch_jobs_28.out.to_capsule_downsample_spot_table_27_27.flatten())
	capsule_combine_sections_17(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_combine_sections_17_8.collect(), capsule_cell_type_mapping_14.out.to_capsule_combine_sections_17_9.collect())
	capsule_run_staligner_26(capsule_downsample_spot_table_27.out.to_capsule_run_staligner_26_24.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_run_staligner_26_25.collect())
	capsule_add_cell_type_colors_16(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_cell_type_colors_16_5.collect(), cell_type_colors_to_add_cell_type_colors_6, capsule_combine_sections_17.out.to_capsule_add_cell_type_colors_16_7)
	capsule_leiden_clustering_rapids_23(capsule_run_staligner_26.out.to_capsule_leiden_clustering_rapids_23_14.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_leiden_clustering_rapids_23_15.flatten(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_leiden_clustering_rapids_23_16.collect())
	capsule_doublemad_mapping_filtering_20(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_doublemad_mapping_filtering_20_12.collect(), capsule_add_cell_type_colors_16.out.to_capsule_doublemad_mapping_filtering_20_13)
	capsule_save_processing_results_18(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_save_processing_results_18_10.collect(), capsule_doublemad_mapping_filtering_20.out.to_capsule_save_processing_results_18_11.collect())
	capsule_add_cluster_labels_to_cells_24(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_cluster_labels_to_cells_24_17.collect(), capsule_save_processing_results_18.out.to_capsule_add_cluster_labels_to_cells_24_18.collect(), capsule_leiden_clustering_rapids_23.out.to_capsule_add_cluster_labels_to_cells_24_19)
	capsule_merge_clusters_25(capsule_add_cluster_labels_to_cells_24.out.to_capsule_merge_clusters_25_20.collect(), capsule_save_processing_results_18.out.to_capsule_merge_clusters_25_21.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_merge_clusters_25_22.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_merge_clusters_25_23.collect())
}
