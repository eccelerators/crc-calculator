all: build

build:
	ant -f build.xml all

sim:
	docker run \
		-v ${PWD}/scripts:/scripts:ro \
		-v ${PWD}/submodules/simstm:/simstm:ro \
		-v ${PWD}/src:/src:ro \
		-v ${PWD}/src-gen:/src-gen:ro \
		-v ${PWD}/tb:/tb:ro \
		ghdl/ghdl:ubuntu22-llvm-11 \
		/bin/bash -c /scripts/sim.sh

clean:
	rm -rf tmp-gen src-gen

.PHONY: all build clean
