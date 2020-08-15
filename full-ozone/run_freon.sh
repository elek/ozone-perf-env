#!/usr/bin/env bash

set -e

kubectl delete job --all

flekszible generate \
    -t namefilter:include=test-runner \
    -t run:args="bash -c 'ozone freon dfsg -t 1 -n 10000 && sleep infinity'" \
    --print | kubectl apply -f -

stern "test-runner"
#kubectl wait --timeout=300s -l job-name=test-runner --for=condition=complete job

#kubectl logs --tail=-1 -l job-name=test-runner | tee results/${TEST_NAME:-result-$(date +%s)}.txt
