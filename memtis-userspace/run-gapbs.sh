#!/bin/bash

#BENCHMARKS="silo gapbs-pr liblinear"
#BENCHMARKS="silo gapbs-bc gapbs-cc gapbs-pr liblinear merci"
BENCHMARKS="gapbs-bc gapbs-bfs gapbs-cc gapbs-pr gapbs-sssp gapbs-tc"
#BENCHMARKS="flexkvs gapbs-bc gapbs-cc gapbs-pr liblinear XSBench"
#BENCHMARKS="gapbs-pr liblinear"
#BENCHMARKS="gapbs-pr gapbs-cc gapbs-bc"
#BENCHMARKS="gapbs-pr"
NVM_RATIO="1:2 1:8 1:16"
max_sizes="20 32 28"

sudo dmesg -c

for BENCH in ${BENCHMARKS};
do
    for NR in $(seq 1 24);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F $((NR*1))GB -T 8 -R ${NR} --cxl -V memtis-cxl
    done
done
