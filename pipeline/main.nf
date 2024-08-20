#!/usr/bin/env nextflow
// hash:sha256:563a6ab13a0f100245541b2a3616e8864221e74bb12878a0ebb1be1ef508683f

nextflow.enable.dsl = 1

capsule_filtering_11_to_capsule_combine_sections_2_1 = channel.create()
markers_to_hierarchical_mapping_cell_type_mapper_2 = channel.fromPath("../data/markers/*", type: 'any', relative: true)
precomputed_stats_to_hierarchical_mapping_cell_type_mapper_3 = channel.fromPath("../data/precomputed_stats/*", type: 'any', relative: true)
capsule_combine_sections_2_to_capsule_hierarchical_mapping_celltypemapper_3_4 = channel.create()
markers_to_flat_mapping_cell_type_mapper_5 = channel.fromPath("../data/markers/*", type: 'any', relative: true)
precomputed_stats_to_flat_mapping_cell_type_mapper_6 = channel.fromPath("../data/precomputed_stats/*", type: 'any', relative: true)
capsule_combine_sections_2_to_capsule_flatmapping_celltypemapper_4_7 = channel.create()
capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_8 = channel.create()
capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_9 = channel.create()
capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_10 = channel.create()
cell_type_colors_to_add_colors_hierarchical_11 = channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)
capsule_hierarchical_mapping_celltypemapper_3_to_capsule_add_colors_7_12 = channel.create()
cell_type_colors_to_add_colors_flat_13 = channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)
capsule_flatmapping_celltypemapper_4_to_capsule_add_colors_flat_8_14 = channel.create()
capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_15 = channel.create()
capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_16 = channel.create()
merscope_720609_mousedev_segmented_rotated_to_add_cluster_labels_to_cells_by_section__17 = channel.fromPath("../data/merscope_720609_mousedev_segmented_rotated/*", type: 'any', relative: true)

// capsule - Combine Sections
process capsule_combine_sections_2 {
	tag 'capsule-5790984'
	container "$REGISTRY_HOST/capsule/56b1d4f6-2a6a-4536-8b35-7c208d62f3ba"

	cpus 2
	memory '52 GB'

	input:
	path 'capsule/data/' from capsule_filtering_11_to_capsule_combine_sections_2_1.collect()

	output:
	path 'capsule/results/*' into capsule_combine_sections_2_to_capsule_hierarchical_mapping_celltypemapper_3_4
	path 'capsule/results/*' into capsule_combine_sections_2_to_capsule_flatmapping_celltypemapper_4_7

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=56b1d4f6-2a6a-4536-8b35-7c208d62f3ba
	export CO_CPUS=2
	export CO_MEMORY=55834574848

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5790984.git" capsule-repo
	git -C capsule-repo checkout c94e874d2e604b53c6cbbeb4242b9d423e4fa27f --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_combine_sections_2_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Hierarchical Mapping - cell_type_mapper
process capsule_hierarchical_mapping_celltypemapper_3 {
	tag 'capsule-4571712'
	container "$REGISTRY_HOST/capsule/7cbe36e9-643b-4dd2-83f1-cf7a655bc382"

	cpus 34
	memory '96 GB'

	input:
	val path2 from markers_to_hierarchical_mapping_cell_type_mapper_2
	val path3 from precomputed_stats_to_hierarchical_mapping_cell_type_mapper_3
	path 'capsule/data/' from capsule_combine_sections_2_to_capsule_hierarchical_mapping_celltypemapper_3_4

	output:
	path 'capsule/results/*' into capsule_hierarchical_mapping_celltypemapper_3_to_capsule_add_colors_7_12

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=7cbe36e9-643b-4dd2-83f1-cf7a655bc382
	export CO_CPUS=34
	export CO_MEMORY=103079215104

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/markers
	mkdir -p capsule/data/precomputed_stats

	ln -s "/tmp/data/markers/$path2" "capsule/data/markers/$path2" # id: 445aa2ae-076f-43aa-a329-6c23a9290c1f
	ln -s "/tmp/data/precomputed_stats/$path3" "capsule/data/precomputed_stats/$path3" # id: 5f8692be-aeb0-4463-9bfa-3f3f664f807d

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4571712.git" capsule-repo
	git -C capsule-repo checkout 5e33b35a08329c7127fe964c6c9fdd243bfa645a --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_hierarchical_mapping_celltypemapper_3_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Flat mapping - cell_type_mapper
process capsule_flatmapping_celltypemapper_4 {
	tag 'capsule-7602887'
	container "$REGISTRY_HOST/capsule/b99e4355-d65b-4348-a287-cde9d6831bc3"

	cpus 36
	memory '72 GB'

	input:
	val path5 from markers_to_flat_mapping_cell_type_mapper_5
	val path6 from precomputed_stats_to_flat_mapping_cell_type_mapper_6
	path 'capsule/data/' from capsule_combine_sections_2_to_capsule_flatmapping_celltypemapper_4_7

	output:
	path 'capsule/results/*' into capsule_flatmapping_celltypemapper_4_to_capsule_add_colors_flat_8_14

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b99e4355-d65b-4348-a287-cde9d6831bc3
	export CO_CPUS=36
	export CO_MEMORY=77309411328

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/markers
	mkdir -p capsule/data/precomputed_stats

	ln -s "/tmp/data/markers/$path5" "capsule/data/markers/$path5" # id: 445aa2ae-076f-43aa-a329-6c23a9290c1f
	ln -s "/tmp/data/precomputed_stats/$path6" "capsule/data/precomputed_stats/$path6" # id: 5f8692be-aeb0-4463-9bfa-3f3f664f807d

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7602887.git" capsule-repo
	git -C capsule-repo checkout 0144828e1b8116823eb5e48a89f36c7b8122fab1 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_flatmapping_celltypemapper_4_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Filtering - Hierarchical
process capsule_double_mad_filtering_hierarchical_5 {
	tag 'capsule-5853172'
	container "$REGISTRY_HOST/capsule/c12178b9-5294-4420-94fb-43751457c7cf"

	cpus 36
	memory '72 GB'

	input:
	path 'capsule/data/' from capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_8

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c12178b9-5294-4420-94fb-43751457c7cf
	export CO_CPUS=36
	export CO_MEMORY=77309411328

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5853172.git" capsule-repo
	git -C capsule-repo checkout 32d9012c7da67ba24a3b4e7116debb42a3293c39 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_double_mad_filtering_hierarchical_5_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Combine Results + Save
process capsule_combine_results_save_6 {
	tag 'capsule-1792859'
	container "$REGISTRY_HOST/capsule/8eb1cb3b-b081-4b12-8813-10a8c08a1d51"

	cpus 8
	memory '64 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_9
	path 'capsule/data/' from capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_10

	output:
	path 'capsule/results/*'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=8eb1cb3b-b081-4b12-8813-10a8c08a1d51
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1792859.git" capsule-repo
	git -C capsule-repo checkout 2cbddb66129689d8f80f6ea5bf5f8151136de2f4 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_combine_results_save_6_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Colors - Hierarchical
process capsule_add_colors_7 {
	tag 'capsule-3136666'
	container "$REGISTRY_HOST/capsule/75566aa0-4659-44a1-83ac-a0139ce461c2"

	cpus 2
	memory '36 GB'

	input:
	val path11 from cell_type_colors_to_add_colors_hierarchical_11
	path 'capsule/data/' from capsule_hierarchical_mapping_celltypemapper_3_to_capsule_add_colors_7_12

	output:
	path 'capsule/results/*' into capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_8

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=75566aa0-4659-44a1-83ac-a0139ce461c2
	export CO_CPUS=2
	export CO_MEMORY=38654705664

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path11" "capsule/data/cell_type_colors/$path11" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3136666.git" capsule-repo
	git -C capsule-repo checkout 5b7e45c1337ace18642c071633d42fe80c6aade5 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_add_colors_7_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Colors - Flat
process capsule_add_colors_flat_8 {
	tag 'capsule-6286069'
	container "$REGISTRY_HOST/capsule/542f20f7-8868-45c7-958c-463f954ce858"

	cpus 2
	memory '36 GB'

	input:
	val path13 from cell_type_colors_to_add_colors_flat_13
	path 'capsule/data/' from capsule_flatmapping_celltypemapper_4_to_capsule_add_colors_flat_8_14

	output:
	path 'capsule/results/*' into capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_15

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=542f20f7-8868-45c7-958c-463f954ce858
	export CO_CPUS=2
	export CO_MEMORY=38654705664

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path13" "capsule/data/cell_type_colors/$path13" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6286069.git" capsule-repo
	git -C capsule-repo checkout 02fb5c09b3d9d8ac7b6ce0a344a910445773d27e --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_add_colors_flat_8_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Filtering - Flat
process capsule_double_mad_filtering_flat_10 {
	tag 'capsule-6132720'
	container "$REGISTRY_HOST/capsule/c47d2a1e-b426-4f7a-aaa8-d2605f13ee6f"

	cpus 36
	memory '72 GB'

	input:
	path 'capsule/data/' from capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_15

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_10

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c47d2a1e-b426-4f7a-aaa8-d2605f13ee6f
	export CO_CPUS=36
	export CO_MEMORY=77309411328

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6132720.git" capsule-repo
	git -C capsule-repo checkout 8699ca6cf514bee60491eac5121844e481c0b00e --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_double_mad_filtering_flat_10_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Filtering
process capsule_filtering_11 {
	tag 'capsule-8257790'
	container "$REGISTRY_HOST/capsule/b4b7bdd0-4078-46c8-9f11-34e926e3caf2"

	cpus 4
	memory '16 GB'
	accelerator 1
	label 'gpu'

	input:
	path 'capsule/data/' from capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_16

	output:
	path 'capsule/results/*' into capsule_filtering_11_to_capsule_combine_sections_2_1

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
	git -C capsule-repo checkout da48d11328d2bc1c2667dfcdaccb8ac82c3fd1d6 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_filtering_11_args}

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Cluster Labels to Cells (By Section)
process capsule_add_cluster_labelsto_cells_by_section_12 {
	tag 'capsule-6665652'
	container "$REGISTRY_HOST/capsule/f2f3fbb8-4e8d-48af-92d8-930121da39e1"

	cpus 4
	memory '16 GB'

	input:
	val path17 from merscope_720609_mousedev_segmented_rotated_to_add_cluster_labels_to_cells_by_section__17

	output:
	path 'capsule/results/*' into capsule_add_cluster_labelsto_cells_by_section_12_to_capsule_filtering_11_16

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

	ln -s "/tmp/data/merscope_720609_mousedev_spatial_domain" "capsule/data/merscope_720609_mousedev_spatial_domain" # id: 76e8c015-0839-4dc9-b620-f723f8961271
	ln -s "/tmp/data/merscope_720609_mousedev_segmented_rotated/$path17" "capsule/data/sections/$path17" # id: b732051b-46e7-4992-b78a-8b88c52f609a

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6665652.git" capsule-repo
	git -C capsule-repo checkout 7cb8fa29d54fc58a2f380dca80a000c02d9ac2fd --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_add_cluster_labelsto_cells_by_section_12_args}

	echo "[${task.tag}] completed!"
	"""
}
