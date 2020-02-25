kubectl delete -f ozone-datanode-statefulset.yaml
sleep 15
kubectl apply -f ozone-datanode-statefulset.yaml
sleep 30
RAFT_ID=$(kubectl logs ozone-datanode-0 | grep "Starting XceiverServerRatis" | awk '{print $8 }')
kubectl exec ozone-datanode-0 -- ozone freon falg -n2000 -b5 -s 4096000 -t1 -r $RAFT_ID
