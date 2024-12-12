#!/usr/bin/env nextflow
// hash:sha256:3daf7e4e80e668f0e0055001ce6f1e17df22ad3f8b7dccf7531f5b6d0831ce7a

nextflow.enable.dsl = 1

capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_1 = channel.create()
capsule_create_parameters_json_21_to_capsule_filtering_11_2 = channel.create()
capsule_create_parameters_json_21_to_capsule_add_cluster_labelsto_cells_by_section_12_3 = channel.create()
merscope_720609_mousedev_segmented_rotated_to_add_spatial_cluster_labels_to_cells_4 = channel.fromPath("../data/merscope_720609_mousedev_segmented_rotated/*", type: 'any', relative: true)
capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_5 = channel.create()
capsule_create_parameters_json_21_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_6 = channel.create()
capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_7 = channel.create()
capsule_create_parameters_json_21_to_capsule_mapping_hierarchial_flat_combined_14_8 = channel.create()
capsule_create_parameters_json_21_to_capsule_add_cell_type_colors_combined_16_9 = channel.create()
cell_type_colors_to_add_cell_type_colors_10 = channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)
capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_11 = channel.create()
capsule_create_parameters_json_21_to_capsule_combine_sections_17_12 = channel.create()
capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_13 = channel.create()
capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_14 = channel.create()
capsule_create_parameters_json_21_to_capsule_save_processing_results_18_15 = channel.create()
capsule_create_parameters_json_21_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_16 = channel.create()
capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_17 = channel.create()

// capsule - QC Filtering & Doublet Detection
process capsule_filtering_11 {
	tag 'capsule-8257790'
	container "$REGISTRY_HOST/capsule/b4b7bdd0-4078-46c8-9f11-34e926e3caf2:cc7125c438dc37dbccfad683916ccac2"

	cpus 4
	memory '16 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_1
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_filtering_11_2.collect()

	output:
	path 'capsule/results/*' into capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_5

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b4b7bdd0-4078-46c8-9f11-34e926e3caf2
	export CO_CPUS=4
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8257790.git" capsule-repo
	git -C capsule-repo checkout 0a19006c4123a7e58b0f759d42cb877225dfced6 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Spatial Cluster Labels to Cells
process capsule_add_cluster_labelsto_cells_by_section_12 {
	tag 'capsule-6665652'
	container "$REGISTRY_HOST/capsule/f2f3fbb8-4e8d-48af-92d8-930121da39e1:359772d473eff5978d6c65c8759c2f2c"

	cpus 4
	memory '16 GB'

	input:
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_add_cluster_labelsto_cells_by_section_12_3.collect()
	val path4 from merscope_720609_mousedev_segmented_rotated_to_add_spatial_cluster_labels_to_cells_4

	output:
	path 'capsule/results/*' into capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_1

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=f2f3fbb8-4e8d-48af-92d8-930121da39e1
	export CO_CPUS=4
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/sections

	ln -s "/tmp/data/merscope_720609_mousedev_segmented_rotated/$path4" "capsule/data/sections/$path4" # id: c140ab6e-c517-44dc-8b0b-cea727f1a0ee
	ln -s "/tmp/data/merscope_720609_mousedev_spatial_domain" "capsule/data/merscope_720609_mousedev_spatial_domain" # id: 9325bf80-2ed8-40df-8cbf-9b36e0b674ed

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6665652.git" capsule-repo
	git -C capsule-repo checkout eedd23c762a77b256e9893cacf9ee56bbff24019 --quiet
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
	memory '16 GB'

	input:
	path 'capsule/data/' from capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_5
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_6.collect()

	output:
	path 'capsule/results/*' into capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=fd80a307-aa9f-4506-bac2-1923bb1050ed
	export CO_CPUS=4
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/mouse_dev_incongruous_genes_list" "capsule/data/incongruous_genes" # id: 5e5ee663-c304-46a9-ba39-c4003cd416a5

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2911647.git" capsule-repo
	git -C capsule-repo checkout 12df85659b712a69313ddebe74e153eab9e7cfc7 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Mapping (Hierarchial + Flat Combined)
process capsule_mapping_hierarchial_flat_combined_14 {
	tag 'capsule-1928280'
	container "$REGISTRY_HOST/capsule/d8f663b8-d522-4ed8-9467-44e8cf0610e2:c009f7a4e58492ed2f4a2886ce07b880"

	cpus 8
	memory '96 GB'

	input:
	path 'capsule/data/' from capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_7
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_mapping_hierarchial_flat_combined_14_8.collect()

	output:
	path 'capsule/results/*/*combined*.h5ad' into capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_13

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

	ln -s "/tmp/data/merscope_720609_mousedev_p0_markers" "capsule/data/markers" # id: 5ab70028-71e6-4358-9159-32f725029b50
	ln -s "/tmp/data/merscope_720609_mousedev_p0_precomp_stats" "capsule/data/precomputed_stats" # id: d2d89f45-64b6-4977-bc81-1acb4c4a2180

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1928280.git" capsule-repo
	git -C capsule-repo checkout 9e3b056013b7661ed4f9d1e077dc5cbf94338468 --quiet
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
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_add_cell_type_colors_combined_16_9.collect()
	val path10 from cell_type_colors_to_add_cell_type_colors_10
	path 'capsule/data/' from capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_11

	output:
	path 'capsule/results/*' into capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_17

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

	ln -s "/tmp/data/cell_type_colors/$path10" "capsule/data/cell_type_colors/$path10" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9300345.git" capsule-repo
	git -C capsule-repo checkout 031d2323e843789553ece6e62e1be5fffba8d9a8 --quiet
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
	memory '64 GB'

	input:
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_combine_sections_17_12.collect()
	path 'capsule/data/sections/' from capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_13.collect()

	output:
	path 'capsule/results/*' into capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_11

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=56b1d4f6-2a6a-4536-8b35-7c208d62f3ba
	export CO_CPUS=16
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5790984.git" capsule-repo
	git -C capsule-repo checkout fd50eda5c7dbff60fe078671a564fe8436564348 --quiet
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
	container "$REGISTRY_HOST/capsule/41e788a7-6656-4df6-af8e-2bace1c80d2f:bde4f067eadc815de578ee7237c71227"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/*/' from capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_14.collect()
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_save_processing_results_18_15.collect()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=41e788a7-6656-4df6-af8e-2bace1c80d2f
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7456539.git" capsule-repo
	git -C capsule-repo checkout a948f60fc6911b1270084c157037fcb23e3f33c4 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Filtering (Hierarchical + Flat Combined)
process capsule_double_mad_filtering_hierarchical_flat_combined_20 {
	tag 'capsule-5619897'
	container "$REGISTRY_HOST/capsule/94c919b2-7a21-4899-a456-f83ab5d1cfe2:18538b5e44c59261e2cd9ea6ef4561f9"

	cpus 16
	memory '64 GB'

	input:
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_16.collect()
	path 'capsule/data/' from capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_17

	output:
	path 'capsule/results/*/hrc_mmc*.h5ad' into capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_14

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=94c919b2-7a21-4899-a456-f83ab5d1cfe2
	export CO_CPUS=16
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5619897.git" capsule-repo
	git -C capsule-repo checkout cadbecbd0992c1fc67d878001335e0ca3a15968a --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Create Parameters JSON
process capsule_create_parameters_json_21 {
	tag 'capsule-9173047'
	container "$REGISTRY_HOST/capsule/240b455d-6375-45de-b176-3885d4a9e7f1:4e400a6ae2582d0c909187ea22440309"

	cpus 2
	memory '1 GB'

	output:
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_filtering_11_2
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_add_cluster_labelsto_cells_by_section_12_3
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_6
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_mapping_hierarchial_flat_combined_14_8
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_add_cell_type_colors_combined_16_9
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_combine_sections_17_12
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_save_processing_results_18_15
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_16

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=240b455d-6375-45de-b176-3885d4a9e7f1
	export CO_CPUS=2
	export CO_MEMORY=1073741824

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9173047.git" capsule-repo
	git -C capsule-repo checkout 159f02027244f186182170cb110b6dd401fa7f83 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_create_parameters_json_21_args}

	echo "[${task.tag}] completed!"
	"""
}
