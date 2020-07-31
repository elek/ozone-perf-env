#!/usr/bin/env bash
set -ex
time sync
START_TIME=$(date +%s.%N)
ozone freon --verbose falg -n100000 -b1 -s 1024 -c ozone-datanode-0.ozone-datanode:9858 -t1 -r dd54b039-f9fa-409f-bbc5-5dcd2ace838d
time sync
END_TIME=$(date +%s.%N)
echo "Total time: $(echo $END_TIME $START_TIME | awk '{print $1 - $2}')"
echo "Test is Done"
sleep 100000
