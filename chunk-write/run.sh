#!/usr/bin/env bash
kubectl delete -f .
kubectl wait pod --for=delete -l component=ozone
kubectl wait configmap --for=delete ozone-config
flekszible generate
kubectl apply -f .
./test.sh
kubectl apply -f freon
