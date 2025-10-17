#!/bin/bash
set -euo pipefail # Fail on error, unset variables, or pipes errors
sudo apt install -y numactl libjemalloc-dev autoconf libnuma-dev libpmem-dev libaio-dev libssl-dev mpich libdb++-dev pcm msr-tools
cd silo
make dbtest -j$(nproc)
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
