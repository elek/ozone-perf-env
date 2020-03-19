#!/usr/bin/env bash
set -x
sleep 20
RAFT_ID=$(cat /data/storage/hdds/VERSION  | grep datanodeUuid | awk -F '=' '{print $2}')
time sync
START_TIME=$(date +%s.%N)
ozone freon --verbose falg -n10000000 -b1 -s 1024 -t1 -r $RAFT_ID
time sync
END_TIME=$(date +%s.%N)
echo "Total time: $(echo $END_TIME $START_TIME | awk '{print $1 - $2}')"
sleep 100000
