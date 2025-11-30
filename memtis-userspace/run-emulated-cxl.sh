#!/bin/bash

#BENCHMARKS="silo gapbs-pr liblinear"
#BENCHMARKS="silo gapbs-bc gapbs-cc gapbs-pr liblinear merci"
BENCHMARKS="flexkvs gapbs-bc gapbs-cc gapbs-pr liblinear XSBench"
#BENCHMARKS="gapbs-pr liblinear"
#BENCHMARKS="gapbs-pr gapbs-cc gapbs-bc"
#BENCHMARKS="gapbs-pr"
NVM_RATIO="1:2 1:8 1:16"
max_sizes="20 32 28"

sudo dmesg -c

for BENCH in ${BENCHMARKS};
do
    #for NR in ${NVM_RATIO};
    for NR in $(seq 1 18);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F $((NR*4))GB -T 16 -R ${NR} --cxl -V memtis-cxl
    done
    for NR in $(seq 1 18);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F $((NR*4))GB -T 8 -R ${NR} --cxl -V memtis-cxl
    done
done

for BENCH in merci;
do
    #for NR in ${NVM_RATIO};
    for NR in $(seq 1 18);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F $((NR*1536))MB -T 16 -R ${NR} --cxl -V memtis-cxl
    done
    for NR in $(seq 1 18);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F $((NR*1536))MB -T 8 -R ${NR} --cxl -V memtis-cxl
    done
done

for BENCH in silo;
do
    #for NR in ${NVM_RATIO};
    for NR in $(seq 1 20);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F $((NR*4))GB -T 16 -R ${NR} --cxl -V memtis-cxl
    done
    for NR in $(seq 1 20);
    do
      ./scripts/run_bench.sh -B ${BENCH} -F $((NR*4))GB -T 8 -R ${NR} --cxl -V memtis-cxl
    done
done
