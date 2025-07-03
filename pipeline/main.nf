#!/usr/bin/env nextflow
// hash:sha256:cb9e86f73f39e268d9f4008b6382e0fca972bb6e5ba9b0bf84ddb3af56ec23fb

// capsule - Create Parameters JSON Full Pipeline
process capsule_create_parameters_json_full_pipeline_21 {
	tag 'capsule-8075583'
	container "$REGISTRY_HOST/capsule/70bdfeb9-e9e7-4d75-90e9-193537ba4897:97ca9f5a1beab4ff486f4071e760e08b"

	cpus 2
	memory '1.875 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> filename.matches("capsule/results/params/.*") ? new File(filename).getName() : null }

	output:
	path 'capsule/results/params/*', emit: to_capsule_filtering_11_1
	path 'capsule/results/params/*', emit: to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_3
	path 'capsule/results/params/*', emit: to_capsule_mapping_hierarchial_flat_combined_14_5
	path 'capsule/results/params/*', emit: to_capsule_add_cell_type_colors_combined_16_7
	path 'capsule/results/params/*', emit: to_capsule_combine_sections_17_10
	path 'capsule/results/params/*', emit: to_capsule_save_processing_results_18_12
	path 'capsule/results/params/*', emit: to_capsule_doublemad_filtering_hierarchical_flat_combined_no_clusters_20_14
	path 'capsule/results/params/*'
	path 'capsule/results/res_params/*', emit: to_capsule_leiden_clustering_rapids_23_17
	path 'capsule/results/params/*', emit: to_capsule_leiden_clustering_rapids_23_18
	path 'capsule/results/params/*', emit: to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_19
	path 'capsule/results/params/*', emit: to_capsule_add_new_cluster_columns_25_24
	path 'capsule/results/res_params/*', emit: to_capsule_add_new_cluster_columns_25_25
	path 'capsule/results/params/*', emit: to_capsule_run_staligner_json_26_26
	path 'capsule/results/params/*', emit: to_capsule_downsample_spot_table_json_27_28
	path 'capsule/results/params/*', emit: to_capsule_dispatch_jobs_28_30

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=70bdfeb9-e9e7-4d75-90e9-193537ba4897
	export CO_CPUS=2
	export CO_MEMORY=2013265920

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8075583.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8075583.git" capsule-repo
	fi
	git -C capsule-repo checkout a400ed971eb2e365f929ac7774c4ce4244b8f55e --quiet
	mv capsule-repo/code capsule/code
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
	tag 'capsule-6617820'
	container "$REGISTRY_HOST/capsule/083774d3-72c4-42d8-96b2-254e81ec52bf:a1c3826b1b55add0a4be63974c46efb9"

	cpus 2
	memory '1 GB'

	input:
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_downsample_spot_table_json_27_29

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=083774d3-72c4-42d8-96b2-254e81ec52bf
	export CO_CPUS=2
	export CO_MEMORY=1073741824

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/xenium_726931_barcodes" "capsule/data/xenium_726931_barcodes" # id: 361c4975-9e72-41fa-af33-837cf648d2d4

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6617820.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6617820.git" capsule-repo
	fi
	git -C capsule-repo checkout 3082796340217c85a51cf7318b8242618a89eb10 --quiet
	mv capsule-repo/code capsule/code
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
	tag 'capsule-8257790'
	container "$REGISTRY_HOST/capsule/b4b7bdd0-4078-46c8-9f11-34e926e3caf2:cc7125c438dc37dbccfad683916ccac2"

	cpus 4
	memory '15 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/params/'
	val path2

	output:
	path 'capsule/results/*', emit: to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_4

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b4b7bdd0-4078-46c8-9f11-34e926e3caf2
	export CO_CPUS=4
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/sections

	ln -s "/tmp/data/xenium_726931_mousedev_preprocessed/$path2" "capsule/data/sections/$path2" # id: 108f4df3-7e33-4d0a-826c-a613df85d3b9

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8257790.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8257790.git" capsule-repo
	fi
	git -C capsule-repo checkout 123cbaf444ca1aa047ad1edaa05e03a338fded21 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Calculate % Incongruous Genes/Cell & Pairs/Cell
process capsule_calculate_incongruous_genes_cell_pairs_cell_13 {
	tag 'capsule-2911647'
	container "$REGISTRY_HOST/capsule/fd80a307-aa9f-4506-bac2-1923bb1050ed:c192a9532b0e8c847b9970f447df0953"

	cpus 4
	memory '15 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_mapping_hierarchial_flat_combined_14_6

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=fd80a307-aa9f-4506-bac2-1923bb1050ed
	export CO_CPUS=4
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/mouse_dev_incongruous_genes_list" "capsule/data/incongruous_genes" # id: 5e5ee663-c304-46a9-ba39-c4003cd416a5

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2911647.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2911647.git" capsule-repo
	fi
	git -C capsule-repo checkout 1adb60cef86c2944d95ef9f3ecea18e6a8f076be --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Downsample Spot Table (JSON)
process capsule_downsample_spot_table_json_27 {
	tag 'capsule-9309116'
	container "$REGISTRY_HOST/capsule/ab5cdc0d-022c-4bf0-b4c5-4d04ed1b2e40:d0c09da2eb67b14a8a2062e75386d77b"

	cpus 48
	memory '192 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/section_metadata/'

	output:
	path 'capsule/results/downsampled/*', emit: to_capsule_run_staligner_json_26_27

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=ab5cdc0d-022c-4bf0-b4c5-4d04ed1b2e40
	export CO_CPUS=48
	export CO_MEMORY=206158430208

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9309116.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9309116.git" capsule-repo
	fi
	git -C capsule-repo checkout 846dce33c4b4b107bc21132892dfd012575c9397 --quiet
	mv capsule-repo/code capsule/code
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
	tag 'capsule-1928280'
	container "$REGISTRY_HOST/capsule/d8f663b8-d522-4ed8-9467-44e8cf0610e2:c009f7a4e58492ed2f4a2886ce07b880"

	cpus 8
	memory '96 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/'

	output:
	path 'capsule/results/mapping_results/*.h5ad', emit: to_capsule_combine_sections_17_11

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=d8f663b8-d522-4ed8-9467-44e8cf0610e2
	export CO_CPUS=8
	export CO_MEMORY=103079215104

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/xenium_p0_DQPQP4_mapping_files" "capsule/data/markers" # id: 4940b042-3c8e-4d28-9701-a087f9de1f3e

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1928280.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1928280.git" capsule-repo
	fi
	git -C capsule-repo checkout 0adf310d5520c07ed8ead828cdf5e3b5bdbbc3f3 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Run STAligner (JSON)
process capsule_run_staligner_json_26 {
	tag 'capsule-1366953'
	container "$REGISTRY_HOST/capsule/ccde4aeb-172d-4a48-bd2e-ed90c58d2a21:895c09a81261d91221eef4fbdaffe51c"

	cpus 16
	memory '60 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/downsampled/'

	output:
	path 'capsule/results/*', emit: to_capsule_leiden_clustering_rapids_23_16

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=ccde4aeb-172d-4a48-bd2e-ed90c58d2a21
	export CO_CPUS=16
	export CO_MEMORY=64424509440

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/xenium_726931_barcodes" "capsule/data/barcodes" # id: 361c4975-9e72-41fa-af33-837cf648d2d4

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1366953.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1366953.git" capsule-repo
	fi
	git -C capsule-repo checkout 07359d1a9ef7de8993716b48f6600119339333bf --quiet
	mv capsule-repo/code capsule/code
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
	tag 'capsule-5790984'
	container "$REGISTRY_HOST/capsule/56b1d4f6-2a6a-4536-8b35-7c208d62f3ba:56258a32c910287ccd1a4dc7663b71af"

	cpus 16
	memory '96 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/mapping_results/sections/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_cell_type_colors_combined_16_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=56b1d4f6-2a6a-4536-8b35-7c208d62f3ba
	export CO_CPUS=16
	export CO_MEMORY=103079215104

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5790984.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5790984.git" capsule-repo
	fi
	git -C capsule-repo checkout a2ea9938107817de0871eae380197a5edc008104 --quiet
	mv capsule-repo/code capsule/code
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
	tag 'capsule-5243173'
	container "$REGISTRY_HOST/capsule/860d5d7c-a602-474f-9697-c1e0991eec3a:a97b569a19f3d1d49aea68113f3d3df4"

	cpus 16
	memory '60 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/'
	path 'capsule/data/res_params/'
	path 'capsule/data/params/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_21

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=860d5d7c-a602-474f-9697-c1e0991eec3a
	export CO_CPUS=16
	export CO_MEMORY=64424509440

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5243173.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5243173.git" capsule-repo
	fi
	git -C capsule-repo checkout 0d5d5cdf03d9d2dfb57acfdd57e39e2d30e3f279 --quiet
	mv capsule-repo/code capsule/code
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
	tag 'capsule-9300345'
	container "$REGISTRY_HOST/capsule/0e2c969f-17f4-4eff-98df-eb3aef50c6b0:a335ec6ed7309f1f5da9e768dd5c8dfe"

	cpus 8
	memory '48 GB'

	input:
	path 'capsule/data/params/'
	val path8
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_doublemad_filtering_hierarchical_flat_combined_no_clusters_20_15

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=0e2c969f-17f4-4eff-98df-eb3aef50c6b0
	export CO_CPUS=8
	export CO_MEMORY=51539607552

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path8" "capsule/data/cell_type_colors/$path8" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9300345.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9300345.git" capsule-repo
	fi
	git -C capsule-repo checkout bfe5330f199d45a740838b4d3fbe0aab86854772 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Filtering (Hierarchical + Flat Combined) (No Clusters)
process capsule_doublemad_filtering_hierarchical_flat_combined_no_clusters_20 {
	tag 'capsule-4960280'
	container "$REGISTRY_HOST/capsule/0baeef90-141c-4327-9efa-d73f4c7e02ce:18538b5e44c59261e2cd9ea6ef4561f9"

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

	export CO_CAPSULE_ID=0baeef90-141c-4327-9efa-d73f4c7e02ce
	export CO_CPUS=16
	export CO_MEMORY=128849018880

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4960280.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4960280.git" capsule-repo
	fi
	git -C capsule-repo checkout f0cc4cb0a8cd0790bfd9c60c2eeafd3efafe9ece --quiet
	mv capsule-repo/code capsule/code
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
	tag 'capsule-7456539'
	container "$REGISTRY_HOST/capsule/41e788a7-6656-4df6-af8e-2bace1c80d2f:efb94ef89b16c91982f2770b45ba3ce1"

	cpus 8
	memory '96 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/*/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_20
	path 'capsule/results/*', emit: to_capsule_add_new_cluster_columns_25_23

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=41e788a7-6656-4df6-af8e-2bace1c80d2f
	export CO_CPUS=8
	export CO_MEMORY=103079215104

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7456539.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7456539.git" capsule-repo
	fi
	git -C capsule-repo checkout 56b6060131fcc4610e6f4e69b003f63a5d316900 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Spatial Cluster Labels to Cells (multiple resolutions)
process capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24 {
	tag 'capsule-1276528'
	container "$REGISTRY_HOST/capsule/552c7050-0249-45ab-9214-c7bde8e869e4:359772d473eff5978d6c65c8759c2f2c"

	cpus 4
	memory '15 GB'

	input:
	path 'capsule/data/params/'
	path 'capsule/data/data_dir/'
	path 'capsule/data/'

	output:
	path 'capsule/results/*', emit: to_capsule_add_new_cluster_columns_25_22

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=552c7050-0249-45ab-9214-c7bde8e869e4
	export CO_CPUS=4
	export CO_MEMORY=16106127360

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1276528.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1276528.git" capsule-repo
	fi
	git -C capsule-repo checkout 0570176bb719ea0764966f6f9983387de88c0edc --quiet
	mv capsule-repo/code capsule/code
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
	tag 'capsule-0283658'
	container "$REGISTRY_HOST/capsule/265f4a36-3de6-4702-b561-be58cf34487c:52eb3bdca7dab6ee15a7d1192d898ba3"

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

	export CO_CAPSULE_ID=265f4a36-3de6-4702-b561-be58cf34487c
	export CO_CPUS=32
	export CO_MEMORY=257698037760

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0283658.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0283658.git" capsule-repo
	fi
	git -C capsule-repo checkout e6b00f636493984cea5d8c5f9a1a2f8df030aecc --quiet
	mv capsule-repo/code capsule/code
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
	xenium_726931_mousedev_preprocessed_to_qc_filtering_doublet_detection_2 = Channel.fromPath("../data/xenium_726931_mousedev_preprocessed/*", type: 'any', relative: true)
	cell_type_colors_to_add_cell_type_colors_8 = Channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)

	// run processes
	capsule_create_parameters_json_full_pipeline_21()
	capsule_dispatch_jobs_28(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_dispatch_jobs_28_30.collect())
	capsule_filtering_11(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_filtering_11_1.collect(), xenium_726931_mousedev_preprocessed_to_qc_filtering_doublet_detection_2)
	capsule_calculate_incongruous_genes_cell_pairs_cell_13(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_3.collect(), capsule_filtering_11.out.to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_4)
	capsule_downsample_spot_table_json_27(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_downsample_spot_table_json_27_28.collect(), capsule_dispatch_jobs_28.out.to_capsule_downsample_spot_table_json_27_29.flatten())
	capsule_mapping_hierarchial_flat_combined_14(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_mapping_hierarchial_flat_combined_14_5.collect(), capsule_calculate_incongruous_genes_cell_pairs_cell_13.out.to_capsule_mapping_hierarchial_flat_combined_14_6)
	capsule_run_staligner_json_26(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_run_staligner_json_26_26.collect(), capsule_downsample_spot_table_json_27.out.to_capsule_run_staligner_json_26_27.collect())
	capsule_combine_sections_17(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_combine_sections_17_10.collect(), capsule_mapping_hierarchial_flat_combined_14.out.to_capsule_combine_sections_17_11.collect())
	capsule_leiden_clustering_rapids_23(capsule_run_staligner_json_26.out.to_capsule_leiden_clustering_rapids_23_16.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_leiden_clustering_rapids_23_17.flatten(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_leiden_clustering_rapids_23_18.collect())
	capsule_add_cell_type_colors_combined_16(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_cell_type_colors_combined_16_7.collect(), cell_type_colors_to_add_cell_type_colors_8, capsule_combine_sections_17.out.to_capsule_add_cell_type_colors_combined_16_9)
	capsule_doublemad_filtering_hierarchical_flat_combined_no_clusters_20(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_doublemad_filtering_hierarchical_flat_combined_no_clusters_20_14.collect(), capsule_add_cell_type_colors_combined_16.out.to_capsule_doublemad_filtering_hierarchical_flat_combined_no_clusters_20_15)
	capsule_save_processing_results_18(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_save_processing_results_18_12.collect(), capsule_doublemad_filtering_hierarchical_flat_combined_no_clusters_20.out.to_capsule_save_processing_results_18_13.collect())
	capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24(capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_19.collect(), capsule_save_processing_results_18.out.to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_20.collect(), capsule_leiden_clustering_rapids_23.out.to_capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24_21)
	capsule_add_new_cluster_columns_25(capsule_add_spatial_cluster_labels_to_cells_multiple_resolutions_24.out.to_capsule_add_new_cluster_columns_25_22.collect(), capsule_save_processing_results_18.out.to_capsule_add_new_cluster_columns_25_23.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_new_cluster_columns_25_24.collect(), capsule_create_parameters_json_full_pipeline_21.out.to_capsule_add_new_cluster_columns_25_25.collect())
}
