#!/usr/bin/env bash
kubectl delete -f .
kubectl wait pod --for=delete -l component=isolated-follower
kubectl wait configmap --for=delete ozone-config
kubectl wait configmap --for=delete isolated-follower-testscript
flekszible generate
kubectl apply -f .
