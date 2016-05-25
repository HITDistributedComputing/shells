#/bin/bash
##
# Use the amazon naivebayes dataset, trains and tests a classifier.
# Need HADOOP and MAHOUT
# To prepare and generate data:
# ./genData_naivebayes.sh
# To run:
# ./run_naivebayes.sh
##

#bayes-train
cd data-naivebayes/
#create directory for Bayes model
 ${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /BigDataBench/bayes
 ${HADOOP_HOME}/bin/hdfs dfs -rm -r /BigDataBench/bayes/model
 ${HADOOP_HOME}/bin/hdfs dfs -put model /BigDataBench/bayes
CUR_DIR=`pwd`
WORK_DIR=/BigDataBench/bayes/data-naivebayes

cd ..
echo "Preparing naivebayes-naivebayes data dir"

echo "WORK_DIR=$CUR_DIR data will be generated in $WORK_DIR"
##export mahout
#tar -zxvf mahout-distribution-0.6.tar.gz

echo "Preparing naivebayes-naivebayes data dir"
mkdir -p ${CUR_DIR}/amazonMR1
mkdir -p ${CUR_DIR}/amazonMR2
mkdir -p ${CUR_DIR}/amazonMR3
mkdir -p ${CUR_DIR}/amazonMR4
mkdir -p ${CUR_DIR}/amazonMR5

cd ../BigDataGeneratorSuite/Text_datagen/
echo "print data size GB :"
read GB
a=${GB}
let L=a*2
./gen_text_data.sh amazonMR1 $L 1900 11500 ${CUR_DIR}/amazonMR1
./gen_text_data.sh amazonMR2 $L 1900 11500 ${CUR_DIR}/amazonMR2
./gen_text_data.sh amazonMR3 $L 1900 11500 ${CUR_DIR}/amazonMR3
./gen_text_data.sh amazonMR4 $L 1900 11500 ${CUR_DIR}/amazonMR4
./gen_text_data.sh amazonMR5 $L 1900 11500 ${CUR_DIR}/amazonMR5
cd ../../E-commerce/data-naivebayes

#python dataread.py $1 $2  you can change the number 
#$1:A number of storage folder
#$2:From the first few rows stored
#$1 ad $2 based on amazonMR
python dataread.py $a 47

echo "Starting to put data into HDFS..."
${HADOOP_HOME}/bin/hdfs dfs -mkdir -p ${WORK_DIR}
${HADOOP_HOME}/bin/hdfs dfs -put ${CUR_DIR}/testdata ${WORK_DIR}
echo "Finished copyFromLocal ,before you run_naivebayes,you should tar mahout-0.6 first"


