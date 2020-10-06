#!/usr/bin/env bash

set -ex

RESULT_FILE=results/result-$(date +%s).txt

kubectl delete job test-freon || true

flekszible generate

kubectl apply -f testscripts-configmap.yaml

#-agentpath:/opt/java-async-profiler/build/libasyncProfiler.so=start,file=/tmp/profile-%t-%p.svg

ARGS=$@
flekszible generate --print \
    -t namefilter:include=test-freon | kubectl apply -f -

#-t env:HADOOP_OPTS=-javaagent:/opt/byteman/lib/byteman.jar=script:/opt/btm/hcfs-write.btm \
#--path hdfs://hdfs-namenode-0.hdfs-namenode:9820
stern test-freon &

kubectl wait --timeout=3000s -l job-name=test-freon --for=condition=complete job

pkill -f stern

echo $@ > $RESULT_FILE

