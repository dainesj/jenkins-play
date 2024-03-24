#!/bin/bash

function jdwait() {
  echo "Sleeping for ${1} seconds"
  sleep $1
  kubectl get pod
}


kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/grafana.yml

jdwait 60


# forwarding 
export GRAF_NAME=$(kubectl get pods | grep grafana- | cut -d' ' -f1 ) ; echo $GRAF_NAME
kubectl port-forward $GRAF_NAME 3000:3000 &

exit 

# use this URL
https://elasticsearch-es-internal-http.devops-tools.svc.cluster.local:9200