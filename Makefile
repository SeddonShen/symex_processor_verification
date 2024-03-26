build:
	 docker build --tag symbolic-microrv32 .
run:
	docker run --rm -it --ulimit='stack=-1:-1' -v $(shell pwd)/src:/home/klee/src symbolic-microrv32 
# docker run --rm -it --ulimit='stack=-1:-1' -v /mnt/data0/symex_processor_verification/src:/home/klee/src symbolic-microrv32 
	