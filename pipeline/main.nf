#!/usr/bin/env nextflow
// hash:sha256:ac9a0f269102d903016bc32546f636cb1560aaadcd8267ecf5a9fcdfab937046

nextflow.enable.dsl = 1

capsule_filtering_11_to_capsule_combine_sections_2_1 = channel.create()
capsule_combine_sections_2_to_capsule_hierarchical_mapping_celltypemapper_3_2 = channel.create()
capsule_combine_sections_2_to_capsule_flatmapping_celltypemapper_4_3 = channel.create()
capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_4 = channel.create()
capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_5 = channel.create()
capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_6 = channel.create()
capsule_hierarchical_mapping_celltypemapper_3_to_capsule_add_colors_7_7 = channel.create()
capsule_flatmapping_celltypemapper_4_to_capsule_add_colors_flat_8_8 = channel.create()
capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_9 = channel.create()
mouse_702265_test_to_filtering_10 = channel.fromPath("../data/mouse_702265_test/*", type: 'any', relative: true)

// capsule - Combine Sections
process capsule_combine_sections_2 {
	tag 'capsule-5790984'
	container "$REGISTRY_HOST/capsule/56b1d4f6-2a6a-4536-8b35-7c208d62f3ba:56258a32c910287ccd1a4dc7663b71af"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_filtering_11_to_capsule_combine_sections_2_1.collect()

	output:
	path 'capsule/results/*' into capsule_combine_sections_2_to_capsule_hierarchical_mapping_celltypemapper_3_2
	path 'capsule/results/*' into capsule_combine_sections_2_to_capsule_flatmapping_celltypemapper_4_3

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
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Hierarchical Mapping - cell_type_mapper
process capsule_hierarchical_mapping_celltypemapper_3 {
	tag 'capsule-4571712'
	container "$REGISTRY_HOST/capsule/7cbe36e9-643b-4dd2-83f1-cf7a655bc382:929bfb7b61403f94753ff7e7fcfce9e7"

	cpus 2
	memory '0 GB'

	input:
	path 'capsule/data/' from capsule_combine_sections_2_to_capsule_hierarchical_mapping_celltypemapper_3_2

	output:
	path 'capsule/results/*' into capsule_hierarchical_mapping_celltypemapper_3_to_capsule_add_colors_7_7

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

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-4571712.git" capsule-repo
	git -C capsule-repo checkout 28f8a19aae0853d806e7e48e3fd391b4328bdaf3 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Flat mapping - cell_type_mapper
process capsule_flatmapping_celltypemapper_4 {
	tag 'capsule-7602887'
	container "$REGISTRY_HOST/capsule/b99e4355-d65b-4348-a287-cde9d6831bc3:35053cecae67686b065bf3e1ce53ad3d"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_combine_sections_2_to_capsule_flatmapping_celltypemapper_4_3

	output:
	path 'capsule/results/*' into capsule_flatmapping_celltypemapper_4_to_capsule_add_colors_flat_8_8

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

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-7602887.git" capsule-repo
	git -C capsule-repo checkout 64a1b58ff3b9880c74daba16f6617cd9e899819f --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Filtering - Hierarchical
process capsule_double_mad_filtering_hierarchical_5 {
	tag 'capsule-5853172'
	container "$REGISTRY_HOST/capsule/c12178b9-5294-4420-94fb-43751457c7cf:18538b5e44c59261e2cd9ea6ef4561f9"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_4

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_5

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
	git -C capsule-repo checkout a2564f72dbceecc684869bb9a3c1f238137b613e --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Combine Results + Save
process capsule_combine_results_save_6 {
	tag 'capsule-1792859'
	container "$REGISTRY_HOST/capsule/8eb1cb3b-b081-4b12-8813-10a8c08a1d51:93f4714eb2b3d0469aa1d7033e47b5a9"

	cpus 2
	memory '8 GB'

	publishDir "$RESULTS_PATH", saveAs: { filename -> new File(filename).getName() }

	input:
	path 'capsule/data/' from capsule_double_mad_filtering_hierarchical_5_to_capsule_combine_results_save_6_5
	path 'capsule/data/' from capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_6

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
	git -C capsule-repo checkout 4ffb4e07851f647bf9c1fca15e3987e883684e07 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Colors - Hierarchical
process capsule_add_colors_7 {
	tag 'capsule-3136666'
	container "$REGISTRY_HOST/capsule/75566aa0-4659-44a1-83ac-a0139ce461c2:a335ec6ed7309f1f5da9e768dd5c8dfe"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_hierarchical_mapping_celltypemapper_3_to_capsule_add_colors_7_7

	output:
	path 'capsule/results/*' into capsule_add_colors_7_to_capsule_double_mad_filtering_hierarchical_5_4

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

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3136666.git" capsule-repo
	git -C capsule-repo checkout 840e91147ec95ffe14cdc19e2a721eca07210139 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Add Colors - Flat
process capsule_add_colors_flat_8 {
	tag 'capsule-6286069'
	container "$REGISTRY_HOST/capsule/542f20f7-8868-45c7-958c-463f954ce858:a335ec6ed7309f1f5da9e768dd5c8dfe"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_flatmapping_celltypemapper_4_to_capsule_add_colors_flat_8_8

	output:
	path 'capsule/results/*' into capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_9

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

	echo "[${task.tag}] cloning git repo..."
	git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-6286069.git" capsule-repo
	git -C capsule-repo checkout 4705e25dfc44bf8eccb929b08fc338fc2238be53 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - DoubleMAD Filtering - Flat
process capsule_double_mad_filtering_flat_10 {
	tag 'capsule-6132720'
	container "$REGISTRY_HOST/capsule/c47d2a1e-b426-4f7a-aaa8-d2605f13ee6f:18538b5e44c59261e2cd9ea6ef4561f9"

	cpus 1
	memory '8 GB'

	input:
	path 'capsule/data/' from capsule_add_colors_flat_8_to_capsule_double_mad_filtering_flat_10_9

	output:
	path 'capsule/results/*' into capsule_double_mad_filtering_flat_10_to_capsule_combine_results_save_6_6

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
	git -C capsule-repo checkout cfb92d0c8f728e460219c0c60b601b07b74ebc11 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - Filtering
process capsule_filtering_11 {
	tag 'capsule-8257790'
	container "$REGISTRY_HOST/capsule/b4b7bdd0-4078-46c8-9f11-34e926e3caf2:4fa6f5e755e4fd6ce453211bc5c1c3b2"

	cpus 4
	memory '16 GB'
	accelerator 1
	label 'gpu'

	input:
	val path10 from mouse_702265_test_to_filtering_10

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

	ln -s "/tmp/data/mouse_702265_test/$path10" "capsule/data/$path10" # id: e3ae210f-4202-4fbe-a2c4-f32c61163d5c

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
