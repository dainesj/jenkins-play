#!/bin/bash

function jdwait() {
  echo "Sleeping for ${1} seconds"
  sleep $1
  kubectl get pod
}

kubectl create namespace devops-tools

# set context
kubectl config set-context --current --namespace devops-tools 

kubectl apply -f https://download.elastic.co/downloads/eck/2.3.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.3.0/operator.yaml
kubectl apply -f elasticsearch/elastic.yml

jdwait 60

export ES_POD_NAME=$(kubectl get pods | grep elastic- | cut -d' ' -f1 ) ; echo $ES_POD_NAME
echo $ES_POD_NAME


echo  "Forwarding"
kubectl port-forward elasticsearch-es-default-0 9200:9200 &

export ELASTIC_PASSWORD=$(kubectl get secrets elasticsearch-es-elastic-user -o jsonpath='{.data.elastic}' | base64 -D )
echo "ES Password is $ELASTIC_PASSWORD"

echo "update password in /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/fluent-bit-configmap.yaml"


exit  
# random notes

kubectl delete -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/elastic.yml

sed -i.bak 's/0L8w81yAjA67M7s6h3jfwfK7/F79f9w68kV8Gr6hvC8F4l6tA/' *yml
sed -i.bak 's/0L8w81yAjA67M7s6h3jfwfK7/F79f9w68kV8Gr6hvC8F4l6tA/' *sh

# set -i bak 's/ir861umc7h976HFp2JX1W9ha/0L8w81yAjA67M7s6h3jfwfK7/g' * 
