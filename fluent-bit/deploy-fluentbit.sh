#!/bin/bash

function jdwait() {
  echo "Sleeping for ${1} seconds"
  sleep $1
  kubectl get pod
}

# Fluent bit - https://medium.com/@shrishs/log-forwarding-from-fluent-bit-to-splunk-cbf2d7846c2d
# kubectl apply -f fluent-bit/fluent-svc-account.yml
# kubectl apply -f fluent-bit/fluent-bit-configmap.yaml
# kubectl apply -f fluent-bit/fluent-bit-ds.yaml



# kubectl logs -l k8s-app=fluent-bit-logging

# 21/03/2024 - Thu

# kubectl apply -f fluent-bit/fluent-bit-secret.yml

kubectl apply -f fluent-bit/fluent-svc-account.yml
kubectl apply -f fluent-bit/fluent-bit-configmap.yaml

# quick test
# kubectl apply -f fluent-bit/fluent-configmap-03-22.yml

kubectl apply -f fluent-bit/fluent-bit-daemonset.yaml



# kubectl apply -f /fluent-bit/fluent-bit.yml
exit 0


export FPOD_NAME=$(kubectl get pods | grep fluent- | cut -d' ' -f1 ) ; echo $FPOD_NAME

alias fluentlog="kubectl logs $FPOD_NAME -f"

# debug
kubectl exec -it fluent-bit-q9tdk ls /buffers


kubectl delete -f fluent-bit/fluent-svc-account.yml
kubectl delete -f fluent-bit/fluent-bit-configmap.yaml
kubectl delete -f fluent-bit/fluent-bit-daemonset.yaml


###############################################################################
parser 
    [PARSER]
        Name        docker
        Format      regex
        Format      json
        Time_Key    time
        Time_Format %Y-%m-%dT%H:%M:%S.%L
        Time_Keep   On
        # Adjust the following to match the log format for your Jenkins logs
        Decode_Field_As   escaped    log
