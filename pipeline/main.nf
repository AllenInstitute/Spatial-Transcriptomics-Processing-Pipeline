#!/usr/bin/env nextflow
// hash:sha256:ab95c8a762a713fb3cd99d96a3534192af04ffb79e67cd8c692f9bd7024c76f0

// capsule - Create Parameters JSON Full Pipeline
process capsule_create_parameters_json_full_pipeline_21 {
	tag 'capsule-0934608'
	container "$REGISTRY_HOST/published/c60dee66-6e1f-4221-ac34-60e3b4a4f869:v3"

	cpus 2
	memory '0 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/params/.*") ? new File(filename).getName() : null }

	output:
	path 'capsule/results/params/*', emit: to_capsule_filtering_11_1
	path 'capsule/results/params/*', emit: to_capsule_mapping_hierarchial_flat_combined_14_4
	path 'capsule/results/params/*', emit: to_capsule_add_cell_type_colors_combined_16_5
	path 'capsule/results/params/*', emit: to_capsule_combine_sections_17_8
	path 'capsule/results/params/*', emit: to_capsule_save_processing_results_18_10
	path 'capsule/results/params/*', emit: to_capsule_doublemad_filtering_20_12
	path 'capsule/results/params/*'
	path 'capsule/results/res_params/*', emit: to_capsule_leiden_clustering_rapids_23_15
	path 'capsule/results/params/*', emit: to_capsule_leiden_clustering_rapids_23_16
	path 'capsule/results/params/*', emit: to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_17
	path 'capsule/results/params/*', emit: to_capsule_add_new_cluster_columns_25_22
	path 'capsule/results/res_params/*', emit: to_capsule_add_new_cluster_columns_25_23
	path 'capsule/results/params/*', emit: to_capsule_run_staligner_json_26_25
	path 'capsule/results/params/*', emit: to_capsule_downsample_spot_table_json_27_26
	path 'capsule/results/params/*', emit: to_capsule_dispatch_jobs_28_28

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c60dee66-6e1f-4221-ac34-60e3b4a4f869
	export CO_CPUS=2
	export CO_MEMORY=0

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0934608.git" capsule-repo
	else
		git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0934608.git" capsule-repo
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
	tag 'capsule-2783986'
	container "$REGISTRY_HOST/published/79ab76f4-d06c-4b4b-8a6b-f0e2d3e24755:v2"

	cpus 2
	memory '1 GB'

	input:
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_downsample_spot_table_json_27_27

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=79ab76f4-d06c-4b4b-8a6b-f0e2d3e24755
	export CO_CPUS=2
	export CO_MEMORY=1073741824

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/barcodes_csv" "capsule/data/barcodes_csv" # id: 361c4975-9e72-41fa-af33-837cf648d2d4

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2783986.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2783986.git" capsule-repo
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
process capsule_filtering_11 {
	tag 'capsule-0717009'
	container "$REGISTRY_HOST/published/b252f053-0776-4db0-882f-45121c541aaf:v7"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/params/'
	val path2

	output:
	path 'capsule/results/*', emit: to_capsule_mapping_hierarchial_flat_combined_14_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b252f053-0776-4db0-882f-45121c541aaf
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
		git clone --filter=tree:0 --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0717009.git" capsule-repo
	else
		git clone --branch v7.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0717009.git" capsule-repo
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
process capsule_downsample_spot_table_json_27 {
	tag 'capsule-0343207'
	container "$REGISTRY_HOST/published/728c54e1-a487-4376-8814-c700c57b5506:v2"

	cpus 48
	memory '192 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/section_metadata/'

	output:
	path 'capsule/results/downsampled/*', emit: to_capsule_run_staligner_json_26_24

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=728c54e1-a487-4376-8814-c700c57b5506
	export CO_CPUS=48
	export CO_MEMORY=206158430208

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0343207.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0343207.git" capsule-repo
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
process capsule_mapping_hierarchial_flat_combined_14 {
	tag 'capsule-8617293'
	container "$REGISTRY_HOST/published/4651fd22-b43c-4a49-aad3-128959f6014a:v4"

	cpus 16
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

	export CO_CAPSULE_ID=4651fd22-b43c-4a49-aad3-128959f6014a
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/mapping_files" "capsule/data/markers" # id: 4940b042-3c8e-4d28-9701-a087f9de1f3e

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8617293.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8617293.git" capsule-repo
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
	tag 'capsule-6755013'
	container "$REGISTRY_HOST/published/63183105-cbc9-4372-bbd8-a138ac1b9b16:v4"

	cpus 16
	memory '42 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/mapping_results/sections/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_cell_type_colors_combined_16_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=63183105-cbc9-4372-bbd8-a138ac1b9b16
	export CO_CPUS=16
	export CO_MEMORY=45097156608

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6755013.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6755013.git" capsule-repo
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
process capsule_run_staligner_json_26 {
	tag 'capsule-0346501'
	container "$REGISTRY_HOST/published/bf53e893-314f-46d9-90a3-725dc8500e96:v2"

	cpus 16
	memory '60 GB'
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

	export CO_CAPSULE_ID=bf53e893-314f-46d9-90a3-725dc8500e96
	export CO_CPUS=16
	export CO_MEMORY=64424509440

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/barcodes_csv" "capsule/data/barcodes" # id: 361c4975-9e72-41fa-af33-837cf648d2d4

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0346501.git" capsule-repo
	else
		git clone --branch v2.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0346501.git" capsule-repo
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
process capsule_add_cell_type_colors_combined_16 {
	tag 'capsule-5374498'
	container "$REGISTRY_HOST/published/1aa84bff-d09e-4bd0-b857-46da3ebf5724:v4"

	cpus 2
	memory '15 GB'

	input:
	path 'capsule/data/params/'
	val path6
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_doublemad_filtering_20_13

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1aa84bff-d09e-4bd0-b857-46da3ebf5724
	export CO_CPUS=2
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path6" "capsule/data/cell_type_colors/$path6" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5374498.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5374498.git" capsule-repo
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
	tag 'capsule-4428961'
	container "$REGISTRY_HOST/published/9a985a2c-9ebc-47f0-a7db-2535471ea2c9:v4"

	cpus 16
	memory '61 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/'
	path 'capsule/data/res_params/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_19

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=9a985a2c-9ebc-47f0-a7db-2535471ea2c9
	export CO_CPUS=16
	export CO_MEMORY=65498251264

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4428961.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4428961.git" capsule-repo
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
process capsule_doublemad_filtering_20 {
	tag 'capsule-0020400'
	container "$REGISTRY_HOST/published/c3fa0840-df74-4c65-86a8-700f7a4d1c6f:v4"

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

	export CO_CAPSULE_ID=c3fa0840-df74-4c65-86a8-700f7a4d1c6f
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0020400.git" capsule-repo
	else
		git clone --branch v4.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0020400.git" capsule-repo
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
	tag 'capsule-2472895'
	container "$REGISTRY_HOST/published/2fcfa1ba-40ec-44fa-ba32-49b9dbc22853:v5"

	cpus 4
	memory '30 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/*/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_18
	path 'capsule/results/*', emit: to_capsule_add_new_cluster_columns_25_21

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=2fcfa1ba-40ec-44fa-ba32-49b9dbc22853
	export CO_CPUS=4
	export CO_MEMORY=32212254720

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2472895.git" capsule-repo
	else
		git clone --branch v5.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2472895.git" capsule-repo
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
process capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24 {
	tag 'capsule-9960820'
	container "$REGISTRY_HOST/published/bd61be7f-e31e-4875-b793-5f50a546ba6d:v3"

	cpus 4
	memory '15 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/data_dir/'
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_new_cluster_columns_25_20

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=bd61be7f-e31e-4875-b793-5f50a546ba6d
	export CO_CPUS=4
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9960820.git" capsule-repo
	else
		git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9960820.git" capsule-repo
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
process capsule_add_new_cluster_columns_25 {
	tag 'capsule-0713522'
	container "$REGISTRY_HOST/published/b0565eb5-d16d-44a6-bf67-ea2de5362d82:v3"

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

	export CO_CAPSULE_ID=b0565eb5-d16d-44a6-bf67-ea2de5362d82
	export CO_CPUS=32
	export CO_MEMORY=257698037760

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0713522.git" capsule-repo
	else
		git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0713522.git" capsule-repo
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
	capsule_filtering_11(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_filtering_11_1.collect(), segmented_data_to_qc_filtering_doublet_detection_2)
	capsule_downsample_spot_table_json_27(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_downsample_spot_table_json_27_26.collect(), capsule_dispatch_jobs_28.out.to_capsule_downsample_spot_table_json_27_27.flatten())
	capsule_mapping_hierarchial_flat_combined_14(capsule_filtering_11.out.to_capsule_mapping_hierarchial_flat_combined_14_3, capsule_create_parameters_json_full_pipeline_21.out.to_capsule_mapping_hierarchial_flat_combined_14_4.collect())
	capsule_combine_sections_17(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_combine_sections_17_8.collect(), capsule_mapping_hierarchial_flat_combined_14.out.to_capsule_combine_sections_17_9.collect())
	capsule_run_staligner_json_26(capsule_downsample_spot_table_json_27.out.to_capsule_run_staligner_json_26_24.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_run_staligner_json_26_25.collect())
	capsule_add_cell_type_colors_combined_16(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_cell_type_colors_combined_16_5.collect(), cell_type_colors_to_add_cell_type_colors_6, capsule_combine_sections_17.out.to_capsule_add_cell_type_colors_combined_16_7)
	capsule_leiden_clustering_rapids_23(capsule_run_staligner_json_26.out.to_capsule_leiden_clustering_rapids_23_14.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_leiden_clustering_rapids_23_15.flatten(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_leiden_clustering_rapids_23_16.collect())
	capsule_doublemad_filtering_20(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_doublemad_filtering_20_12.collect(), capsule_add_cell_type_colors_combined_16.out.to_capsule_doublemad_filtering_20_13)
	capsule_save_processing_results_18(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_save_processing_results_18_10.collect(), capsule_doublemad_filtering_20.out.to_capsule_save_processing_results_18_11.collect())
	capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_17.collect(), capsule_save_processing_results_18.out.to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_18.collect(), capsule_leiden_clustering_rapids_23.out.to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_19)
	capsule_add_new_cluster_columns_25(capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24.out.to_capsule_add_new_cluster_columns_25_20.collect(), capsule_save_processing_results_18.out.to_capsule_add_new_cluster_columns_25_21.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_new_cluster_columns_25_22.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_new_cluster_columns_25_23.collect())
}
