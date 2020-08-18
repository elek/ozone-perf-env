#!/usr/bin/env bash

set -ex

kubectl delete job --all

flekszible generate --print \
    -t namefilter:include=test-runner \
    -t run:args="/opt/testscripts/parquet.sh $*" | kubectl apply -f -

stern test-runner &

kubectl wait --timeout=3000s -l job-name=test-runner --for=condition=complete job

pkill -f stern

kubectl logs --tail=-1 -l job-name=test-runner | grep "parquet at" | grep finished

