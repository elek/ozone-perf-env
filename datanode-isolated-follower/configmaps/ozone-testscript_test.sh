#!/usr/bin/env bash
set -ex
time sync
START_TIME=$(date +%s.%N)
ozone freon --verbose falg -n100000 -b1 -s 1024 -c ozone-datanode-0.ozone-datanode:9858 -t1 -r 85cc7199-2aa1-4b81-9062-ca295e88d568
time sync
END_TIME=$(date +%s.%N)
echo "Total time: $(echo $END_TIME $START_TIME | awk '{print $1 - $2}')"
echo "Test is Done"
sleep 100000
