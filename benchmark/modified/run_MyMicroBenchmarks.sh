#!/bin/bash
##
# Micro Benchmarks Workload: sort, grep, wordcount
# Need HADOOP 
# To prepare and generate data:
#  ./genData_MyMicroBenchmarks.sh
# To run:  
#  ./run_MyMicroBenchmarks.sh param1 param2
# @param1
# choice of workload type: 1. grep 2. wordcount 3. sort
# @param2
# work dir on HDFS, /BigDataBench/wordcount by default
# @param3
# job id
##
WORK_DIR=/BigDataBench/wordcount
#try to locate Hadoop
if [ ! -e $HADOOP ]; then
  echo "Can't find hadoop in $HADOOP, exiting"
  exit 1
fi
#select algo
algorithm=( grep wordcount sort )
if [ -n "$1" ]; then
  choice=$1
else
  echo "Please select a number to choose the corresponding Workload algorithm"
  echo "1. ${algorithm[0]} Workload"
  echo "2. ${algorithm[1]} Workload"
  echo "3. ${algorithm[2]} Workload"
  read -p "Enter your choice : " choice
fi
echo "Workload: MR ${algorithm[$choice-1]}"
Workloadtype=${algorithm[$choice-1]} 

#select directory
if [ -z "$2" ]; then
  read -p "Please enter the directory that contains your input on HDFS：" IN_DIR
  if [ -z "$IN_DIR" ]; then
    IN_DIR=/BigDataBench/wordcount/in
    echo "No input, use default ${IN_DIR}"
  fi

else
  if [ "x$2" = "xdefault" ]; then
    IN_DIR=/BigDataBench/wordcount
    echo "Use default dir ${IN_DIR}"

  else
    IN_DIR=$2
    #echo "Use parameter input dir ${IN_DIR}"
  fi
fi
echo "Input Files: ${IN_DIR}"
echo "Output Dir: ${WORK_DIR}/out/wordcount"
echo "Bench Logging to: benchLogs/job_$3"

#test if the dir is correct
#exit 1

#if and run
if [ "x$Workloadtype" == "xgrep" ]; then
  ${HADOOP_HOME}/bin/hdfs dfs -rm -r -skipTrash ${WORK_DIR}/out/grep_$3
  time ${HADOOP_HOME}/bin/hadoop jar  ${HADOOP_HOME}/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar grep ${IN_DIR} ${WORK_DIR}/out/grep_$3 a*xyz
  ${HADOOP_HOME}/bin/hdfs dfs -rm -r -skipTrash ${WORK_DIR}/out/grep_$3

elif [ "x$Workloadtype" == "xwordcount" ]; then
  hdfs dfs -rm -r -skipTrash ${WORK_DIR}/out/wordcount_$3
  time ${HADOOP_HOME}/bin/hadoop jar  ${HADOOP_HOME}/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar  wordcount  $IN_DIR  ${WORK_DIR}/out/wordcount_$3 
  hdfs dfs -rm -r -skipTrash ${WORK_DIR}/out/wordcount_$3
fi
