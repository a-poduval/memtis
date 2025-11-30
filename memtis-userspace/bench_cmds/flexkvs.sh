#!/bin/bash

BIN=/mydata/memtis/memtis-userspace/bench_dir/flexkvs/kvsbench
#BENCH_RUN="${BIN}/dbtest --verbose --bench ycsb --num-threads 20 --scale-factor 400000 --ops-per-worker=1000000000 --slow-exit"
BENCH_RUN="${BIN} -T 250 -w 20 -h 0.25 127.0.0.1:1211 -S 34359738368 -t 20"
#BENCH_RUN_CUSTOMT="${BIN} -T 250 -w 20 -h 0.25 127.0.0.1:1211 -S 34359738368 -t "
BENCH_RUN_CUSTOMT="${BIN} -T 400 -w 20 -h 0.25 127.0.0.1:1211 -S 68719476736 -t "
BENCH_DRAM=""

#####
# Silo ~59500MB memory footprint
#####

if [[ "x${NVM_RATIO}" == "x1:32" ]]; then
    BENCH_DRAM="1803MB"
elif [[ "x${NVM_RATIO}" == "x1:16" ]]; then
    BENCH_DRAM="3500MB"
elif [[ "x${NVM_RATIO}" == "x1:8" ]]; then
    BENCH_DRAM="6600MB"
elif [[ "x${NVM_RATIO}" == "x1:4" ]]; then
    BENCH_DRAM="11900MB"
elif [[ "x${NVM_RATIO}" == "x1:2" ]]; then
    BENCH_DRAM="19800MB"
elif [[ "x${NVM_RATIO}" == "x1:1" ]]; then
    BENCH_DRAM="29750MB"
elif [[ "x${NVM_RATIO}" == "x1:0" ]]; then
    BENCH_DRAM="70000MB"
fi

export BENCH_RUN_CUSTOMT
export BENCH_DRAM
