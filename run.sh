#!/bin/bash

LOG_FILE=build.log

function jdwait() {
  echo "Sleeping for ${1} seconds"
  sleep $1
  kubectl get pod
}

logger ()
{
    echo "`date` $1" | tee -a $LOG_FILE
}

logger "Starting minikube"
minikube start  --cpus 4 --memory 12192 -v 9 --disk-size 60G

logger "Deploying Elasticsearch"
elasticsearch/deploy-elasticsearch.sh

logger "Updating truststore with Elasticsearch CAs"
ssl/create-pkcs12.sh

logger "Deploying Jenkins"
jenkins/deploy-jenkins.sh

logger "You will need to manually update Jenkins to install 'stress' etc."

logger "Deploying Fluent Bit"
fluent-bit/deploy-fluentbit.sh

logger "Deploying Grafana"
grafana/deploy-grafana.sh