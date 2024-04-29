#!/usr/bin/env nextflow
// hash:sha256:f0a1da1fe17e98b88d15768f6ead69b5630b16df02c2e3907d999284799fba38

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
mouse_702265_test_to_filtering_16 = channel.fromPath("../data/mouse_702265_test/*", type: 'any', relative: true)

// capsule - Combine Sections
process capsule_combine_sections_2 {
	tag 'capsule-5790984'
	container "$REGISTRY_HOST/capsule/56b1d4f6-2a6a-4536-8b35-7c208d62f3ba"

	cpus 1
	memory '8 GB'

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
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5790984.git" capsule-repo
	git -C capsule-repo checkout 989095bd85a99e66bbcad3a602636ba6f0ede958 --quiet
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

	cpus 2
	memory '0 GB'

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
	export CO_CPUS=2
	export CO_MEMORY=0

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/markers/$path2" "capsule/data/$path2" # id: 4f6014eb-2f79-4fff-b523-d6a8b27d1d71
	ln -s "/tmp/data/precomputed_stats/$path3" "capsule/data/$path3" # id: 0ad8bd39-ca8d-46bb-b99b-87d0683f364e

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4571712.git" capsule-repo
	git -C capsule-repo checkout 28f8a19aae0853d806e7e48e3fd391b4328bdaf3 --quiet
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

	cpus 1
	memory '8 GB'

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
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/markers/$path5" "capsule/data/$path5" # id: 4f6014eb-2f79-4fff-b523-d6a8b27d1d71
	ln -s "/tmp/data/precomputed_stats/$path6" "capsule/data/$path6" # id: 0ad8bd39-ca8d-46bb-b99b-87d0683f364e

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7602887.git" capsule-repo
	git -C capsule-repo checkout 64a1b58ff3b9880c74daba16f6617cd9e899819f --quiet
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

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_8

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_9

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c12178b9-5294-4420-94fb-43751457c7cf
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5853172.git" capsule-repo
	git -C capsule-repo checkout b4576f4f8e50bd1c3ae5cdf688725668e1a3bb8c --quiet
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
	git -C capsule-repo checkout ff1243d7bff5e4f663c15b4ef909bacfac306cd3 --quiet
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

	cpus 1
	memory '8 GB'

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
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/cell_type_colors/$path11" "capsule/data/$path11" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3136666.git" capsule-repo
	git -C capsule-repo checkout 840e91147ec95ffe14cdc19e2a721eca07210139 --quiet
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

	cpus 1
	memory '8 GB'

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
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	ln -s "/tmp/data/cell_type_colors/$path13" "capsule/data/$path13" # id: ada9bde4-502c-43e2-8e6d-517d02744905

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6286069.git" capsule-repo
	git -C capsule-repo checkout 4705e25dfc44bf8eccb929b08fc338fc2238be53 --quiet
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

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_15

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_10

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=c47d2a1e-b426-4f7a-aaa8-d2605f13ee6f
	export CO_CPUS=1
	export CO_MEMORY=8589934592

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6132720.git" capsule-repo
	git -C capsule-repo checkout e34d933c434fcd64ad886836a26db9966f33c558 --quiet
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
	val path16 from mouse_702265_test_to_filtering_16

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

	ln -s "/tmp/data/mouse_702265_test/$path16" "capsule/data/$path16" # id: e3ae210f-4202-4fbe-a2c4-f32c61163d5c

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-8257790.git" capsule-repo
	git -C capsule-repo checkout 0d0f15ec0b3357b47d0a4385b3ddd850fa9fe231 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}
