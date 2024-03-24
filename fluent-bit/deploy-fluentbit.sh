#!/bin/bash

function jdwait() {
  echo "Sleeping for ${1} seconds"
  sleep $1
  kubectl get pod
}

# Fluent bit - https://medium.com/@shrishs/log-forwarding-from-fluent-bit-to-splunk-cbf2d7846c2d
# kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-svc-account.yml
# kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit-configmap.yaml
# kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit-ds.yaml



# kubectl logs -l k8s-app=fluent-bit-logging

# 21/03/2024 - Thu

# kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit-secret.yml

kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-svc-account.yml
kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit-configmap.yaml

# quick test
# kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-configmap-03-22.yml

kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit-daemonset.yaml



# kubectl apply -f //Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit.yml
exit 0

jdwait 15

export FPOD_NAME=$(kubectl get pods | grep fluent- | cut -d' ' -f1 ) ; echo $FPOD_NAME

alias fluentlog="kubectl logs $FPOD_NAME -f"

# debug
kubectl exec -it fluent-bit-q9tdk ls /buffers


kubectl delete -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-svc-account.yml
kubectl delete -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit-configmap.yaml
kubectl delete -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit-daemonset.yaml


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
