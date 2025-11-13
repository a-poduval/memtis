#!/bin/bash

cd tools/perf/
make -j$(nproc)
sudo mkdir -p /lib/linux-tools/$(uname -r)
sudo cp perf /lib/linux-tools/$(uname -r)
