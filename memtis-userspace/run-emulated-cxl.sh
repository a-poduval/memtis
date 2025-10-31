#!/bin/bash

#BENCHMARKS="silo gapbs-pr liblinear"
BENCHMARKS="silo gapbs-bc gapbs-cc gapbs-pr liblinear merci"
#BENCHMARKS="gapbs-pr liblinear"
#BENCHMARKS="gapbs-pr gapbs-cc gapbs-bc"
#BENCHMARKS="gapbs-pr"
NVM_RATIO="1:2 1:8 1:16"
max_sizes="20 32 28"

sudo dmesg -c

for BENCH in ${BENCHMARKS};
do
    #for NR in ${NVM_RATIO};
    for NR in $(seq 1 32);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F ${NR}GB -T 16 -R ${NR} --cxl -V memtis-cxl
    done
    for NR in $(seq 1 32);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F ${NR}GB -T 8 -R ${NR} --cxl -V memtis-cxl
    done
done
