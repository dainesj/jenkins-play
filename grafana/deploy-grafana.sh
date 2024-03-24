#!/bin/bash

function jdwait() {
  echo "Sleeping for ${1} seconds"
  sleep $1
  kubectl get pod
}


kubectl apply -f grafana/grafana.yml

jdwait 60


# forwarding 
GRAF_NAME=$(kubectl get pods | grep grafana- | cut -d' ' -f1 ) ; echo $GRAF_NAME
kubectl port-forward $GRAF_NAME 3000:3000 &

exit 

# use this URL
https://elasticsearch-es-internal-http.devops-tools.svc.cluster.local:9200