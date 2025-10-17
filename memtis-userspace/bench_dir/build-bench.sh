#!/bin/bash
set -euo pipefail # Fail on error, unset variables, or pipes errors
sudo apt install -y numactl libjemalloc-dev autoconf
cd silo
make dbtest -j$(nproc)
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
