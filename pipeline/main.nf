#!/usr/bin/env nextflow
// hash:sha256:814fdfbcc502b3be23366c858365da45d55c989d6c48233024406f1559857801

nextflow.enable.dsl = 1

capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_1 = channel.create()
merscope_720609_mousedev_segmented_rotated_to_add_spatial_cluster_labels_to_cells_2 = channel.fromPath("../data/merscope_720609_mousedev_segmented_rotated/*", type: 'any', relative: true)
capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_3 = channel.create()
capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_4 = channel.create()
cell_type_colors_to_add_cell_type_colors_5 = channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)
capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_6 = channel.create()
capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_7 = channel.create()
capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_8 = channel.create()
capsule_save_processing_results_18_to_capsule_make_qc_plots_19_9 = channel.create()
capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_10 = channel.create()

// capsule - QC Filtering & Doublet Detection
process capsule_filtering_11 {
	tag 'capsule-0717009'
	container "$REGISTRY_HOST/published/b252f053-0776-4db0-882f-45121c541aaf:v3"

	cpus 4
	memory '16 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_1

	output:
	path 'capsule/results/*' into capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_3

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b252f053-0776-4db0-882f-45121c541aaf
	export CO_CPUS=4
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v3.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-0717009.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_filtering_11_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Spatial Cluster Labels to Cells
process capsule_add_cluster_labelsto_cells_by_section_12 {
	tag 'capsule-1255110'
	container "$REGISTRY_HOST/published/dbbbf1ec-3c5d-4c6f-b699-b705b4d926be:v1"

	cpus 4
	memory '16 GB'

	input:
	val path2 from merscope_720609_mousedev_segmented_rotated_to_add_spatial_cluster_labels_to_cells_2

	output:
	path 'capsule/results/*' into capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_1

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=dbbbf1ec-3c5d-4c6f-b699-b705b4d926be
	export CO_CPUS=4
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/sections

	ln -s "/tmp/data/merscope_720609_mousedev_segmented_rotated/$path2" "capsule/data/sections/$path2" # id: c140ab6e-c517-44dc-8b0b-cea727f1a0ee
	ln -s "/tmp/data/merscope_720609_mousedev_spatial_domain" "capsule/data/merscope_720609_mousedev_spatial_domain" # id: 9325bf80-2ed8-40df-8cbf-9b36e0b674ed

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1255110.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_add_cluster_labelsto_cells_by_section_12_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Calculate % Incongruous Genes/Cell & Pairs/Cell
process capsule_calculate_incongruous_genes_cell_pairs_cell_13 {
	tag 'capsule-6238842'
	container "$REGISTRY_HOST/published/b2697690-5109-422f-bf7b-d15b8cb9ca6b:v1"

	cpus 4
	memory '16 GB'

	input:
	path 'capsule/data/sections/' from capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_3

	output:
	path 'capsule/results/*' into capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_4

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b2697690-5109-422f-bf7b-d15b8cb9ca6b
	export CO_CPUS=4
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/mouse_dev_incongruous_genes_list" "capsule/data/incongruous_genes" # id: 5e5ee663-c304-46a9-ba39-c4003cd416a5

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6238842.git" capsule-repo
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
	tag 'capsule-8617293'
	container "$REGISTRY_HOST/published/4651fd22-b43c-4a49-aad3-128959f6014a:v1"

	cpus 8
	memory '96 GB'

	input:
	path 'capsule/data/sections/' from capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_4

	output:
	path 'capsule/results/*/*combined*.h5ad' into capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=4651fd22-b43c-4a49-aad3-128959f6014a
	export CO_CPUS=8
	export CO_MEMORY=103079215104

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/merscope_720609_mousedev_p0_markers" "capsule/data/markers" # id: 5ab70028-71e6-4358-9159-32f725029b50
	ln -s "/tmp/data/merscope_720609_mousedev_p0_precomp_stats" "capsule/data/precomputed_stats" # id: d2d89f45-64b6-4977-bc81-1acb4c4a2180

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8617293.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_mapping_hierarchial_flat_combined_14_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Cell Type Colors
process capsule_add_cell_type_colors_combined_16 {
	tag 'capsule-5374498'
	container "$REGISTRY_HOST/published/1aa84bff-d09e-4bd0-b857-46da3ebf5724:v1"

	cpus 8
	memory '48 GB'

	input:
	val path5 from cell_type_colors_to_add_cell_type_colors_5
	path 'capsule/data/' from capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_6

	output:
	path 'capsule/results/*' into capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_10

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=1aa84bff-d09e-4bd0-b857-46da3ebf5724
	export CO_CPUS=8
	export CO_MEMORY=51539607552

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path5" "capsule/data/cell_type_colors/$path5" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5374498.git" capsule-repo
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
	tag 'capsule-6755013'
	container "$REGISTRY_HOST/published/63183105-cbc9-4372-bbd8-a138ac1b9b16:v1"

	cpus 16
	memory '64 GB'

	input:
	path 'capsule/data/sections/' from capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_7.collect()

	output:
	path 'capsule/results/*' into capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_6

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=63183105-cbc9-4372-bbd8-a138ac1b9b16
	export CO_CPUS=16
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6755013.git" capsule-repo
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
	tag 'capsule-2472895'
	container "$REGISTRY_HOST/published/2fcfa1ba-40ec-44fa-ba32-49b9dbc22853:v1"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/whole_dataset/' from capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_8.collect()

	output:
	path 'capsule/results/*'
	path 'capsule/results/sections/*' into capsule_save_processing_results_18_to_capsule_make_qc_plots_19_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=2fcfa1ba-40ec-44fa-ba32-49b9dbc22853
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-2472895.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_save_processing_results_18_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Make QC Plots
process capsule_make_qc_plots_19 {
	tag 'capsule-7374711'
	container "$REGISTRY_HOST/published/b7521d4a-1f10-4681-b7c5-77359adef80e:v1"

	cpus 8
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/mouse_folder/sections/' from capsule_save_processing_results_18_to_capsule_make_qc_plots_19_9.flatten()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b7521d4a-1f10-4681-b7c5-77359adef80e
	export CO_CPUS=8
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/merscope_720609_mousedev_spatial_domain" "capsule/data/spatial_domain" # id: 9325bf80-2ed8-40df-8cbf-9b36e0b674ed

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7374711.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_make_qc_plots_19_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Filtering (Hierarchical + Flat Combined)
process capsule_double_mad_filtering_hierarchical_flat_combined_20 {
	tag 'capsule-3438348'
	container "$REGISTRY_HOST/published/24c246fd-f670-431d-a811-0d01b6b3b4c4:v1"

	cpus 16
	memory '64 GB'

	input:
	path 'capsule/data/' from capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_hierarchical_flat_combined_20_10

	output:
	path 'capsule/results/whole_dataset/CDM*.h5ad' into capsule_double_mad_filtering_hierarchical_flat_combined_20_to_capsule_save_processing_results_18_8

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=24c246fd-f670-431d-a811-0d01b6b3b4c4
	export CO_CPUS=16
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone --branch v1.0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3438348.git" capsule-repo
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_double_mad_filtering_hierarchical_flat_combined_20_args}

	echo "[${task.tag}] completed!"
	"""
}
