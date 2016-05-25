#!/bin/bash
WORK_DIR=/BigDataBench/bayes
cd mahout-distribution-0.6/bin

#for index in 2 4 8 16 24
#do
index=24
echo "===========running the $index th workload...=============="
time ./mahout testclassifier -m ${WORK_DIR}/model -d  ${WORK_DIR}/data-naivebayes/testdata_$index
#done
