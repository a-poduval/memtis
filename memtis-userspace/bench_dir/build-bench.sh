#!/bin/bash
set -euo pipefail # Fail on error, unset variables, or pipes errors

sudo apt install -y numactl libjemalloc-dev autoconf libnuma-dev libpmem-dev libaio-dev libssl-dev mpich libdb++-dev pcm msr-tools
cd silo
make dbtest -j$(nproc)
cd ..

git clone https://github.com/SNU-ARC/MERCI
cd MERCI
git apply ../merci.diff
mkdir -p data/4_filtered/amazon_All
cd data/4_filtered/amazon_All
wget https://pages.cs.wisc.edu/~apoduval/MERCI/data/4_filtered/amazon_All/amazon_All_test_filtered.txt
wget https://pages.cs.wisc.edu/~apoduval/MERCI/data/4_filtered/amazon_All/amazon_All_train_filtered.txt
cd ../../..
mkdir -p data/5_patoh/amazon_All/partition_2748/
cd data/5_patoh/amazon_All/partition_2748/
wget https://pages.cs.wisc.edu/~apoduval/MERCI/data/5_patoh/amazon_All/partition_2748/amazon_All_train_filtered.txt.part.2748
cd ../../../..
cd 4_performance_evaluation/
mkdir bin
make -j20
cd ../..

cd flexkvs
git apply ../flexkvs.diff
make -j20
cd ..

git clone https://github.com/sbeamer/gapbs.git
cd gapbs
patch -p1 < ../gapbs-pr.diff
make pr; make pr gen-twitter
make -j$(nproc)
cd ..

git clone https://github.com/ANL-CESAR/XSBench.git
cd XSBench/openmp-threading
make -j$(nproc)

cd ../../liblinear
patch -p1 < ../liblinear.diff
make dataset
make -j$(nproc)
cd ../..
make -j$(nproc)
