#!/bin/bash

function jdwait() {
  echo "Sleeping for ${1} seconds"
  sleep $1
  kubectl get pod
}

log ()
{
    echo "`date` $1"
}

# create namespace
kubectl create namespace devops-tools

# set context
kubectl config set-context --current --namespace devops-tools 

# apply RB
kubectl apply -f jenkins/serviceAccount.yaml
kubectl create -f jenkins/volume.yaml
kubectl apply -f jenkins/deployment.yaml

# status
kubectl get deployments 

# svc
kubectl apply -f jenkins/service.yaml

jdwait 60

# get svc
kubectl get svc

POD_NAME=$(kubectl get pods | grep jenkins- | cut -d' ' -f1 ) ; echo $POD_NAME


log "Jenkins init password"
kubectl exec -it $POD_NAME cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools 2>&1 | grep -v DEPRECATED




log "Forwarding"
kubectl port-forward $POD_NAME 8080:8080 &

exit 
# need at add 
docker exec -it minikube /bin/bash
docker ps | grep jenk
docker exec -t -i --user root b21bf8456edd /bin/bash
apt-get update -y
apt-get install stress -y
apt-get install vim -y
apt-get install inotify-tools -y
chmod -R 777 /

export POD_NAME=$(kubectl get pods | grep jenkins- | cut -d' ' -f1 ) ; echo $POD_NAME
kubectl port-forward $POD_NAME 8080:8080 &



kubectl delete -f jenkins/deployment.yaml