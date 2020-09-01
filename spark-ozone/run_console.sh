#!/usr/bin/env bash

kubectl delete job --all

flekszible generate --print -t namefilter:include=test-runner -t run:args="sleep infinity" | kubectl apply -f -

