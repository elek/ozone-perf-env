#!/usr/bin/env bash

set -ex

RESULT_FILE=results/result-$(date +%s).txt

kubectl delete job --all

#-agentpath:/opt/java-async-profiler/build/libasyncProfiler.so=start,file=/tmp/profile-%t-%p.svg

flekszible generate --print \
    -t namefilter:include=test-runner \
    -t env:BTM_SCRIPT=hcfs-read.btm \
    -t run:args="/opt/testscripts/parquet.sh $*" | kubectl apply -f -

stern test-runner &

kubectl wait --timeout=3000s -l job-name=test-runner --for=condition=complete job

pkill -f stern

echo $@ > $RESULT_FILE
kubectl logs --tail=-1 -l job-name=test-runner | tee -a $RESULT_FILE | grep "parquet at" | grep finished

