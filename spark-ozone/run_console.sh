#!/usr/bin/env bash

kubectl delete job --all

flekszible generate --print -t namefilter:include=test-runner -t run:args="sleep infinity" | kubectl apply -f -

kubectl wait --timeout=300s -l job-name=test-runner --for=condition=complete job

kubectl logs --tail=30 -l job-name=test-runner | tee -a results/wordcount.txt

