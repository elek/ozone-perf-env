#!/usr/bin/env bash

set -e

kubectl delete job --all

flekszible generate \
    -t namefilter:include=test-runner \
    -t env:TEST_MAPPERS=${TEST_MAPPERS:-2} \
    -t env:TEST_SIZE=${TEST_SIZE:-10G} \
    --print | kubectl apply -f -

kubectl wait --timeout=300s -l job-name=test-runner --for=condition=complete job

kubectl logs --tail=-1 -l job-name=test-runner | tee results/${TEST_NAME:-result-$(date +%s)}.txt
