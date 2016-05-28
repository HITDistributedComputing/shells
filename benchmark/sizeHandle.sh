#author:Zhenhua Sheng
#date:2016/5/26
#target:output file name with size input

#!/bin/bash
fiveHundredMB=500000000
str="/BigDataBench/wordcount/in/{"
numOfFiveHundredMB=`expr $1 / $fiveHundredMB`
for i in $(seq 1 $numOfFiveHundredMB)
do
    str="${str}wiki_${i}"
    if [ $i != $numOfFiveHundredMB ]
    then
        str="${str},"
    fi
done
size=`expr $1 % $fiveHundredMB`
size=`expr $size / 1000`
hundredThousand=`expr $size / 100000`
if [ $hundredThousand != 0 ]
then
    str="${str},"
    for i in $(seq 1 $hundredThousand) 
    do
        str="${str}Google/google_100000_${i}"
        if [ $i != $hundredThousand ]
        then
            str="${str},"
        fi
    done
fi
tenThousand=`expr $size % 100000 / 10000`
if [ $tenThousand != 0 ]
then
    str="${str},"
    for i in $(seq 1 $tenThousand)
    do 
        str="${str}Google/google_10000_${i}"
	if [ $i != $tenThousand ]
        then
            str="${str},"
        fi
    done
fi
thousand=`expr $size % 10000 / 1000`
if [ $thousand != 0 ]
then
    str="${str},"
    for i in $(seq 1 $thousand)
    do
        str="${str}Google/google_1000_${i}"
        if [ $i != $thousand ]
        then
            str="${str},"
        fi
    done
fi
hundred=`expr $size % 1000 / 100`
if [ $hundred != 0 ]
then
    str="${str},"
    for i in $(seq 1 $hundred)
    do
        str="${str}Google/google_100_${i}"
        if [ $i != $hundred ]
        then
            str="${str},"
        fi
    done
fi
ten=`expr $size % 100 / 10`
if [ $ten != 0 ]
then
    str="${str},"
    for i in $(seq 1 $ten)
    do
        str="${str}Google/google_10_${i}"
        if [ $i != $ten ]
        then
            str="${str},"
        fi
    done
fi
one=`expr $size % 10`
if [ $one != 0 ]
then
    str="${str},"
    for i in $(seq 1 $one)
    do
        str="${str}google_1_${i}"
        if [ $i != $one ]
        then
            str="${str},"
        fi
    done
fi
str="${str}}"
#file=./run_workload_$2.sh
echo $str
