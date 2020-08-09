#!/usr/bin/env bash

set -e
run_test_job() {
   kubectl delete job --all
   kubectl wait -l job-name=test-runner --for=delete pod || true

   flekszible -s job -d - generate \
       -t "env:HADOOP_USER_NAME=$HADOOP_USER_NAME" \
       -t "run:args=$2" | kubectl apply -f -
   kubectl wait --timeout=300s -l job-name=test-runner --for=condition=complete job
   echo $2 > results/$1.txt
   kubectl logs --tail=30 -l job-name=test-runner | tee -a results/$1.txt
}

export HADOOP_USER_NAME=root
run_test_job "ozone-single-byte" "ozone freon dfsg -n 1000 --copy-buffer=1"
run_test_job "ozone-buffered" "ozone freon dfsg -n 1000"


export HADOOP_USER_NAME=hadoop
run_test_job "hdfs-single-byte" "ozone freon dfsg -n 1000 --copy-buffer=1 --path=hdfs://hdfs-namenode-0.hdfs-namenode:9820/"
run_test_job "hdfs-buffered" "ozone freon dfsg -n 1000 --path=hdfs://hdfs-namenode-0.hdfs-namenode:9820"
