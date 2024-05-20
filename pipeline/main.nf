#!/usr/bin/env nextflow
// hash:sha256:c43ba55c2a8fb349a65ec72e807c1a923683d98ed2f252e46c8b0b6102e78158

nextflow.enable.dsl = 1

capsule_filtering_11_to_capsule_combine_sections_2_1 = channel.create()
precomputed_stats_to_hierarchical_mapping_cell_type_mapper_2 = channel.fromPath("../data/precomputed_stats/*", type: 'any', relative: true)
markers_to_hierarchical_mapping_cell_type_mapper_3 = channel.fromPath("../data/markers/*", type: 'any', relative: true)
capsule_combine_sections_2_to_capsule_hierarchical_mapping_celltypemapper_3_4 = channel.create()
precomputed_stats_to_flat_mapping_cell_type_mapper_5 = channel.fromPath("../data/precomputed_stats/*", type: 'any', relative: true)
markers_to_flat_mapping_cell_type_mapper_6 = channel.fromPath("../data/markers/*", type: 'any', relative: true)
capsule_combine_sections_2_to_capsule_flatmapping_celltypemapper_4_7 = channel.create()
capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_8 = channel.create()
capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_9 = channel.create()
capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_10 = channel.create()
cell_type_colors_to_add_colors_hierarchical_11 = channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)
capsule_hierarchical_mapping_celltypemapper_3_to_capsule_add_colors_7_12 = channel.create()
cell_type_colors_to_add_colors_flat_13 = channel.fromPath("../data/cell_type_colors/*", type: 'any', relative: true)
capsule_flatmapping_celltypemapper_4_to_capsule_add_colors_flat_8_14 = channel.create()
capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_15 = channel.create()
whole_dataset_to_filtering_16 = channel.fromPath("../data/whole_dataset/*", type: 'any', relative: true)

// capsule - Combine Sections
process capsule_combine_sections_2 {
	tag 'capsule-5790984'
	container "$REGISTRY_HOST/capsule/56b1d4f6-2a6a-4536-8b35-7c208d62f3ba"

	cpus 2
	memory '16 GB'

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
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5790984.git" capsule-repo
	git -C capsule-repo checkout 797847043bae4cbcc26742c2a206657b886905a4 --quiet
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

	cpus 8
	memory '64 GB'

	input:
	val path2 from precomputed_stats_to_hierarchical_mapping_cell_type_mapper_2
	val path3 from markers_to_hierarchical_mapping_cell_type_mapper_3
	path 'capsule/data/' from capsule_combine_sections_2_to_capsule_hierarchical_mapping_celltypemapper_3_4

	output:
	path 'capsule/results/*' into capsule_hierarchical_mapping_celltypemapper_3_to_capsule_add_colors_7_12

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=7cbe36e9-643b-4dd2-83f1-cf7a655bc382
	export CO_CPUS=8
	export CO_MEMORY=68719476736

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/precomputed_stats
	mkdir -p capsule/data/markers

	ln -s "/tmp/data/precomputed_stats/$path2" "capsule/data/precomputed_stats/$path2" # id: 0ad8bd39-ca8d-46bb-b99b-87d0683f364e
	ln -s "/tmp/data/markers/$path3" "capsule/data/markers/$path3" # id: 4f6014eb-2f79-4fff-b523-d6a8b27d1d71

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4571712.git" capsule-repo
	git -C capsule-repo checkout 6a1af0d5e717371a1653d23e48f12316bc2acb4b --quiet
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

	cpus 4
	memory '32 GB'

	input:
	val path5 from precomputed_stats_to_flat_mapping_cell_type_mapper_5
	val path6 from markers_to_flat_mapping_cell_type_mapper_6
	path 'capsule/data/' from capsule_combine_sections_2_to_capsule_flatmapping_celltypemapper_4_7

	output:
	path 'capsule/results/*' into capsule_flatmapping_celltypemapper_4_to_capsule_add_colors_flat_8_14

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=b99e4355-d65b-4348-a287-cde9d6831bc3
	export CO_CPUS=4
	export CO_MEMORY=34359738368

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/precomputed_stats
	mkdir -p capsule/data/markers

	ln -s "/tmp/data/precomputed_stats/$path5" "capsule/data/precomputed_stats/$path5" # id: 0ad8bd39-ca8d-46bb-b99b-87d0683f364e
	ln -s "/tmp/data/markers/$path6" "capsule/data/markers/$path6" # id: 4f6014eb-2f79-4fff-b523-d6a8b27d1d71

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7602887.git" capsule-repo
	git -C capsule-repo checkout d3f0bfe74e81e7a849adeb486494485b1a8df242 --quiet
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

	cpus 4
	memory '32 GB'

	input:
	path 'capsule/data/' from capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_8

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c12178b9-5294-4420-94fb-43751457c7cf
	export CO_CPUS=4
	export CO_MEMORY=34359738368

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

	cpus 2
	memory '8 GB'

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
	export CO_CPUS=2
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-1792859.git" capsule-repo
	git -C capsule-repo checkout 3c34d711e7c69aee3097ee7ae28154a6c2a0d878 --quiet
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
	memory '16 GB'

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
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path11" "capsule/data/cell_type_colors/$path11" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3136666.git" capsule-repo
	git -C capsule-repo checkout c6254319371d26e821b0c2934307d2dc02fa6f14 --quiet
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
	memory '16 GB'

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
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch
	mkdir -p capsule/data/cell_type_colors

	ln -s "/tmp/data/cell_type_colors/$path13" "capsule/data/cell_type_colors/$path13" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6286069.git" capsule-repo
	git -C capsule-repo checkout a04c5b53aa139c50a07bb037f469fd00d5c58ea5 --quiet
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

	cpus 2
	memory '16 GB'

	input:
	path 'capsule/data/' from capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_15

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_10

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c47d2a1e-b426-4f7a-aaa8-d2605f13ee6f
	export CO_CPUS=2
	export CO_MEMORY=17179869184

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6132720.git" capsule-repo
	git -C capsule-repo checkout a0d4fea973afa00779ae115deee782a1e89d2373 --quiet
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
	val path16 from whole_dataset_to_filtering_16

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
	mkdir -p capsule/data/whole_dataset

	ln -s "/tmp/data/whole_dataset/$path16" "capsule/data/whole_dataset/$path16" # id: 156575d0-c080-4d30-b253-68b88cafe275

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8257790.git" capsule-repo
	git -C capsule-repo checkout ea094d9bf834702ab2d3906c4725ff0df7fd80ab --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run ${params.capsule_filtering_11_args}

	echo "[${task.tag}] completed!"
	"""
}
