#!/bin/sh

# load environment variates
source /etc/profile

for index in 9 10 11 13 14 15; do
ssh slaveserver$index "

cd /opt/hadoop/
rm -rf logs
"
done

