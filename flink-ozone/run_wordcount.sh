#!/usr/bin/env bash

set -ex

kubectl delete job --all
flekszible generate --print -t namefilter:include=test-runner -t run:args="./bin/flink run ./examples/batch/WordCount.jar --input o3fs://bucket1.vol1/key1 --output o3fs://bucket1.vol1/fileout-$RANDOM" | kubectl apply -f -

kubectl wait --timeout=300s -l app=flink,component=test-runner --for=condition=complete job

kubectl logs --tail=30 -l job-name=test-runner | tee -a results/wordcount.txt


