#!/usr/bin/env nextflow
// hash:sha256:7195b0609b43926dc5c4052200541d961df5ce064f6146eca872cf1a0ed9d4ed

nextflow.enable.dsl = 1

merscope_720609_mousedev_segmented_rotated_to_qc_filtering_doublet_detection_1 = channel.fromPath("../data/merscope_720609_mousedev_segmented_rotated/*", type: 'any', relative: true)
capsule_create_parameters_json_21_to_capsule_filtering_11_2 = channel.create()
capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_3 = channel.create()
capsule_create_parameters_json_21_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_4 = channel.create()
capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_5 = channel.create()
capsule_create_parameters_json_21_to_capsule_mapping_hierarchial_flat_combined_14_6 = channel.create()
capsule_create_parameters_json_21_to_capsule_add_cell_type_colors_combined_16_7 = channel.create()
cell_type_colors_to_add_cell_type_colors_8 = channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)
capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_9 = channel.create()
capsule_create_parameters_json_21_to_capsule_combine_sections_17_10 = channel.create()
capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_11 = channel.create()
capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_12 = channel.create()
capsule_create_parameters_json_21_to_capsule_save_processing_results_18_13 = channel.create()
capsule_create_parameters_json_21_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_14 = channel.create()
capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_15 = channel.create()

// capsule - QC Filtering & Doublet Detection
process capsule_filtering_11 {
	tag 'capsule-8257790'
	container "$REGISTRY_HOST/capsule/b4b7bdd0-4078-46c8-9f11-34e926e3caf2:cc7125c438dc37dbccfad683916ccac2"

	cpus 4
	memory '16 GB'
	accelerator 1
	label 'gpu'

	input:
	val path1 from merscope_720609_mousedev_segmented_rotated_to_qc_filtering_doublet_detection_1
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_filtering_11_2.collect()

	output:
	path 'capsule/results/*' into capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_3

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
	mkdir -p capsule/data/sections

	ln -s "/tmp/data/merscope_720609_mousedev_segmented_rotated/$path1" "capsule/data/sections/$path1" # id: c140ab6e-c517-44dc-8b0b-cea727f1a0ee

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8257790.git" capsule-repo
	git -C capsule-repo checkout 2ae0fcef468732e2e34019055199cc234a9297a5 --quiet
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
	path 'capsule/data/' from capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_3
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_4.collect()

	output:
	path 'capsule/results/*' into capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_5

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
	git -C capsule-repo checkout 41559c4578eacfc3840bf257a3f7326d1d33dbc1 --quiet
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
	path 'capsule/data/' from capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_5
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_mapping_hierarchial_flat_combined_14_6.collect()

	output:
	path 'capsule/results/*/*combined*.h5ad' into capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_11

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

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1928280.git" capsule-repo
	git -C capsule-repo checkout 2d0b5d49371885085157e7871350d28317fe4021 --quiet
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
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_add_cell_type_colors_combined_16_7.collect()
	val path8 from cell_type_colors_to_add_cell_type_colors_8
	path 'capsule/data/' from capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_9

	output:
	path 'capsule/results/*' into capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_15

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
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9300345.git" capsule-repo
	git -C capsule-repo checkout aa43cc96118abcf5cb158527f83a7576830f1ee2 --quiet
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
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_combine_sections_17_10.collect()
	path 'capsule/data/sections/' from capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_11.collect()

	output:
	path 'capsule/results/*' into capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_9

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
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5790984.git" capsule-repo
	git -C capsule-repo checkout 4f886799f690a22829360b5a0903a5b1e31d04a6 --quiet
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
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/*/' from capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_12.collect()
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_save_processing_results_18_13.collect()

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
	git -C capsule-repo checkout cbfaa994ad94523b7a853865aa26beb0f7aa0428 --quiet
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
	memory '128 GB'

	input:
	path 'capsule/data/params/' from capsule_create_parameters_json_21_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_14.collect()
	path 'capsule/data/' from capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_15

	output:
	path 'capsule/results/*/hrc_mmc*.h5ad' into capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_12

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=94c919b2-7a21-4899-a456-f83ab5d1cfe2
	export CO_CPUS=16
	export CO_MEMORY=137438953472

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5619897.git" capsule-repo
	git -C capsule-repo checkout 1531825c62ad8ea7b83a00ec83b871e01925fecb --quiet
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

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	output:
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_filtering_11_2
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_4
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_mapping_hierarchial_flat_combined_14_6
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_add_cell_type_colors_combined_16_7
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_combine_sections_17_10
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_save_processing_results_18_13
	path 'capsule/results/*' into capsule_create_parameters_json_21_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_14
	path 'capsule/results/*'

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
	git -C capsule-repo checkout f17a979e18f91940bca8ff11378581b94eb8c49b --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_create_parameters_json_21_args}

	echo "[${task.tag}] completed!"
	"""
}
