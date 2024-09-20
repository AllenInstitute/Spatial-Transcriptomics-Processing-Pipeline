#!/usr/bin/env nextflow
// hash:sha256:e99f331967afacc401c1530c1467ea5852d1212efe9c08b646f69ccc1edaeac8

nextflow.enable.dsl = 1

capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_combined_10_1 = channel.create()
capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_2 = channel.create()
merscope_720609_mousedev_segmented_rotated_to_add_spatial_cluster_labels_to_cells_3 = channel.fromPath("../data/merscope_720609_mousedev_segmented_rotated/*", type: 'any', relative: true)
capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_4 = channel.create()
capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_5 = channel.create()
cell_type_colors_to_add_cell_type_colors_6 = channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)
capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_7 = channel.create()
capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_8 = channel.create()
capsule_double_mad_filtering_flat_mapping_20_to_capsule_save_processing_results_18_9 = channel.create()
capsule_double_mad_filtering_combined_10_to_capsule_double_mad_filtering_flat_mapping_20_10 = channel.create()
capsule_save_processing_results_18_to_capsule_make_qc_plots_21_11 = channel.create()

// capsule - DoubleMAD Filtering
process capsule_double_mad_filtering_combined_10 {
	tag 'capsule-6375645'
	container "$REGISTRY_HOST/capsule/a378c3f4-cb07-4e58-9e66-372cbb8639fb:18538b5e44c59261e2cd9ea6ef4561f9"

	cpus 36
	memory '72 GB'

	input:
	path 'capsule/data/' from capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_combined_10_1

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_combined_10_to_capsule_double_mad_filtering_flat_mapping_20_10

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a378c3f4-cb07-4e58-9e66-372cbb8639fb
	export CO_CPUS=36
	export CO_MEMORY=77309411328

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6375645.git" capsule-repo
	git -C capsule-repo checkout bb032111a8590694e19214343886a43fe0e0a233 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_double_mad_filtering_combined_10_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - QC Filtering & Doublet Detection
process capsule_filtering_11 {
	tag 'capsule-8257790'
	container "$REGISTRY_HOST/capsule/b4b7bdd0-4078-46c8-9f11-34e926e3caf2:b162d832f77e7ae13871d3dc88acad3f"

	cpus 4
	memory '16 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_2

	output:
	path 'capsule/results/*' into capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_4

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
	git -C capsule-repo checkout cd08911315ca722b3a4121ac197b84dae6f4fdd1 --quiet
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
	tag 'capsule-6665652'
	container "$REGISTRY_HOST/capsule/f2f3fbb8-4e8d-48af-92d8-930121da39e1:359772d473eff5978d6c65c8759c2f2c"

	cpus 4
	memory '16 GB'

	input:
	val path3 from merscope_720609_mousedev_segmented_rotated_to_add_spatial_cluster_labels_to_cells_3

	output:
	path 'capsule/results/*' into capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_2

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

	ln -s "/tmp/data/merscope_720609_mousedev_segmented_rotated/$path3" "capsule/data/sections/$path3" # id: c140ab6e-c517-44dc-8b0b-cea727f1a0ee
	ln -s "/tmp/data/merscope_720609_mousedev_spatial_domain" "capsule/data/merscope_720609_mousedev_spatial_domain" # id: 9325bf80-2ed8-40df-8cbf-9b36e0b674ed

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6665652.git" capsule-repo
	git -C capsule-repo checkout 62b528cde19565c0cdf88b1d510ccb1774ecba08 --quiet
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
	tag 'capsule-2911647'
	container "$REGISTRY_HOST/capsule/fd80a307-aa9f-4506-bac2-1923bb1050ed:c192a9532b0e8c847b9970f447df0953"

	cpus 4
	memory '16 GB'

	input:
	path 'capsule/data/sections/' from capsule_filtering_11_to_capsule_calculate_incongruous_genes_cell_pairs_cell_13_4

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
	git -C capsule-repo checkout 811450c0c4bc44a3145553b04241a35284a1d366 --quiet
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
	container "$REGISTRY_HOST/capsule/d8f663b8-d522-4ed8-9467-44e8cf0610e2:aa7466220abbedc999180c0a94c68ace"

	cpus 36
	memory '96 GB'

	input:
	path 'capsule/data/sections/' from capsule_calculate_incongruous_genes_cell_pairs_cell_13_to_capsule_mapping_hierarchial_flat_combined_14_5

	output:
	path 'capsule/results/*/*combined*.h5ad' into capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_8

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=d8f663b8-d522-4ed8-9467-44e8cf0610e2
	export CO_CPUS=36
	export CO_MEMORY=103079215104

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/merscope_720609_mousedev_p0_markers" "capsule/data/markers" # id: 5ab70028-71e6-4358-9159-32f725029b50
	ln -s "/tmp/data/merscope_720609_mousedev_p0_precomp_stats" "capsule/data/precomputed_stats" # id: d2d89f45-64b6-4977-bc81-1acb4c4a2180

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1928280.git" capsule-repo
	git -C capsule-repo checkout 0020058788ae29d148337f5739244557aad750cb --quiet
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
	tag 'capsule-9300345'
	container "$REGISTRY_HOST/capsule/0e2c969f-17f4-4eff-98df-eb3aef50c6b0:a335ec6ed7309f1f5da9e768dd5c8dfe"

	cpus 8
	memory '32 GB'

	input:
	val path6 from cell_type_colors_to_add_cell_type_colors_6
	path 'capsule/data/' from capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_7

	output:
	path 'capsule/results/*' into capsule_add_cell_type_colors_combined_16_to_capsule_double_mad_filtering_combined_10_1

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=0e2c969f-17f4-4eff-98df-eb3aef50c6b0
	export CO_CPUS=8
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path6" "capsule/data/cell_type_colors/$path6" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-9300345.git" capsule-repo
	git -C capsule-repo checkout 508b8f431f58ab260073f469f2ab485c33a9f1ea --quiet
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
	path 'capsule/data/sections/' from capsule_mapping_hierarchial_flat_combined_14_to_capsule_combine_sections_17_8.collect()

	output:
	path 'capsule/results/*' into capsule_combine_sections_17_to_capsule_add_cell_type_colors_combined_16_7

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
	git -C capsule-repo checkout d66755cb99ff50c1eb9553425735e7fa08f49f4b --quiet
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
	container "$REGISTRY_HOST/capsule/41e788a7-6656-4df6-af8e-2bace1c80d2f:93f4714eb2b3d0469aa1d7033e47b5a9"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_double_mad_filtering_flat_mapping_20_to_capsule_save_processing_results_18_9

	output:
	path 'capsule/results/*'
	path 'capsule/results/sections/*' into capsule_save_processing_results_18_to_capsule_make_qc_plots_21_11

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
	git -C capsule-repo checkout f3461ecda428be0b03d6b57602c2238e919b1335 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_save_processing_results_18_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Filtering (Flat Mapping)
process capsule_double_mad_filtering_flat_mapping_20 {
	tag 'capsule-7352220'
	container "$REGISTRY_HOST/capsule/a6c610f4-d0d3-4d0f-82c6-167cb2681b59:18538b5e44c59261e2cd9ea6ef4561f9"

	cpus 16
	memory '64 GB'

	input:
	path 'capsule/data/' from capsule_double_mad_filtering_combined_10_to_capsule_double_mad_filtering_flat_mapping_20_10

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_flat_mapping_20_to_capsule_save_processing_results_18_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=a6c610f4-d0d3-4d0f-82c6-167cb2681b59
	export CO_CPUS=16
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7352220.git" capsule-repo
	git -C capsule-repo checkout b2f7ea26457a3bbb949d562604c96154cd39438d --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_double_mad_filtering_flat_mapping_20_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Make QC Plots
process capsule_make_qc_plots_21 {
	tag 'capsule-1849574'
	container "$REGISTRY_HOST/capsule/8bed6b42-6f69-4769-a3b7-e67fa4730e07:941cf1cadde871198815bd4e8c5ae899"

	cpus 8
	memory '32 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/sections/' from capsule_save_processing_results_18_to_capsule_make_qc_plots_21_11.flatten()

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8bed6b42-6f69-4769-a3b7-e67fa4730e07
	export CO_CPUS=8
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1849574.git" capsule-repo
	git -C capsule-repo checkout dac0a89ed7c5b1d787bbf244f143fab673ec9faf --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
