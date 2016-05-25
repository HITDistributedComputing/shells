#!/bin/bash
##
# Use the Google dataset, Run PageRank-plain, a PageRank calculation algorithm on hadoop.
# Need HADOOP and PEGASUS
# To prepare and generate data:
# ./genData_PageRank.sh
# @param1
# Iteration times
# @param2
# HDFS dir for generated data to store, /BigDataBench/pagerank as default
# To run:
# ./run_PageRank.sh [#_of_nodes] [#_of_reducers] [makesym or nosym] [#_Iterations_of_GenGragh]
##

echo "Generate PageRank data"

WORK_DIR=`pwd`       
HDFS_DIR=/BigDataBench/pagerank

mkdir $WORK_DIR/data-PageRank

#set the hdfs directory
if [ -z "$2" ]; then
  read -p "Please Enter the HDFS directory for generated data:" TMP_DIR
  if [ -n "$TMP_DIR" ]; then
    HDFS_DIR=$TMP_DIR
  fi
else
  if [ "x$2" != "xdefault" ]; then
    HDFS_DIR=$2
  fi
fi
echo "Okay, we will use ${HDFS_DIR} as the HDFS directory."

#set the Iteration times
if [ -z "$1" ]; then
  read -p "Please Enter The Iterations of GenGragh: " I
else 
  I=$1
fi

echo "WORK_DIR=$WORK_DIR data will be generated in ${HDFS_DIR}"

#/////////////////////////////////////////////////////////////////////////////
#Parameters:
# -o:Output graph file name (default:'graph.txt')
# -m:Matrix (in Maltab notation) (default:'0.9 0.5; 0.5 0.1')
# -i:Iterations of Kronecker product (default:5)
# -s:Random seed (0 - time seed) (default:0)
#/////////////////////////////////////////////////////////////////////////////

../../BigDataGeneratorSuite/Graph_datagen/gen_kronecker_graph  -o:$WORK_DIR/data-PageRank/Google_genGraph_$I.txt -m:"0.8305 0.5573; 0.4638 0.3021" -i:$I

head -4 $WORK_DIR/data-PageRank/Google_genGraph_$I.txt > $WORK_DIR/data-PageRank/Google_parameters_$I
sed 1,4d $WORK_DIR/data-PageRank/Google_genGraph_$I.txt > $WORK_DIR/data-PageRank/Google_genGraph_$I.tmp

mv $WORK_DIR/data-PageRank/Google_genGraph_$I.tmp $WORK_DIR/data-PageRank/Google_genGraph_$I.txt

hdfs dfs -rm -r ${HDFS_DIR}/Google_genGraph_$I.txt
$HADOOP_HOME/bin/hdfs dfs -mkdir -p ${HDFS_DIR}
$HADOOP_HOME/bin/hdfs dfs -put $WORK_DIR/data-PageRank/Google_genGraph_$I.txt ${HDFS_DIR}
echo "copyFromLocal To HDFS succeded"
