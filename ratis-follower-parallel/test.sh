#/usr/bin/env bash
echo "asd"
set -x
sleep 20
RAFT_ID=$(cat /storage/hdds/VERSION  | grep datanodeUuid | awk -F '=' '{print $2}')
ozone freon --verbose falg -n30000 -b1 -s 1024 -t1 -r $RAFT_ID
#sleep forever as k8s doesn't support restartPolicy: Never
date
time sync
date
sleep 100000
