#!/bin/bash
##
# Use the Google dataset, Run PageRank-plain, a PageRank calculation algorithm on hadoop.
# Need HADOOP and PEGASUS
# To prepare and generate data:
# ./genData_PageRank.sh
# To run:
# ./run_PageRank.sh [#_of_nodes] [#_of_reducers] [makesym or nosym] [#_Iterations_of_GenGragh]
##

for index in 23 24 25 26 27
do
  ./genMyData_PageRank.sh $index default
done
