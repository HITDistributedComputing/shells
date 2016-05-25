#!/bin/bash
##
OUT_DIR=/bigdatabench_spark/micro_result
#WORK_DIR=/BigDataBench/wordcount/in/wiki_nobel
JAR_FILE=/opt/home/hadoop/tools/bigdatabench_spark/JAR_FILE/*.jar
algorithm=( Grep Wordcount)
# Sort
if [ -n "$1" ]; then
  choice=$1
else
  echo "Please select a number to choose the corresponding Workload algorithm"
  echo "1. ${algorithm[0]} Workload"
  echo "2. ${algorithm[1]} Workload"
  echo "3. ${algorithm[2]} Workload"
 
  read -p "Enter your choice : " choice
fi

echo "Workload: Spark ${algorithm[$choice-1]}"
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

if [ "x$Workloadtype" == "xGrep" ]; then
#echo "the keyword to filter the text K:"
#read K
hdfs dfs -rm -r $OUT_DIR/grep_$3
time spark-submit --class cn.ac.ict.bigdatabench.Grep \
--master yarn-cluster \
$JAR_FILE $IN_DIR "a*xyz" $OUT_DIR/grep_$3
hdfs dfs -rm -r $OUT_DIR/grep_$3

elif [ "x$Workloadtype" == "xWordcount" ]; then
hdfs dfs -rm -r $OUT_DIR/wordcount_$3
time spark-submit --class cn.ac.ict.bigdatabench.WordCount \
--master yarn-cluster \
$JAR_FILE $IN_DIR $OUT_DIR/wordcount_$3
hdfs dfs -rm -r $OUT_DIR/wordcount_$3

#if [ "x$Workloadtype" == "xSort" ]; then
#hdfs dfs -rm -r $OUT_DIR/sort
#time spark-submit --class cn.ac.ict.bigdatabench.Sort\
#--master yarn-cluster \
#$JAR_FILE $IN_DIR $OUT_DIR/sort

fi 
#--num-executors 20 \
#--executor-cores 2 \
#--executor-memory 2g \
