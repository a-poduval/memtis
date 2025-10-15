
### dataset for Liblinear

DATASET_DIR = datasets/

.PHONY: dataset
dataset: ${DATASET_DIR} ${DATASET_DIR}/kddb

${DATASET_DIR}:
	mkdir -p $@

${DATASET_DIR}/kddb: ${DATASET_DIR}/kddb.bz2
	bunzip2 $^

${DATASET_DIR}/kddb.xz:
	wget -P ${DATASET_DIR} https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary/kddb.bz2
