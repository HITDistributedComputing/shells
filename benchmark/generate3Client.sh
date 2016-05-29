echo "generating $1 mixed jobs for 3 clients in current dir..."
cd /home/hadoop/workspace/WorkloadGenerator/src
javac cn/hit/cst/ssl/*.java
java cn/hit/cst/ssl/WorkloadGenerator ./ $1 3
chmod +x run_workload_*.sh
mv run_workload_0.sh /home/hadoop/workspace/workloads/mr_test/
scp run_workload_1.sh hadoop@slaveserver16:/home/hadoop/workspace/workloads/mr_test/
scp run_workload_2.sh hadoop@vzeng-vm:/home/hadoop/workspace/workloads/mr_test/
