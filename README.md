# Observe

General overview:
- Setup Jenkins
	- Setup Jenkins build
	- https://www.guru99.com/create-builds-jenkins-freestyle-project.html
- Setup Fluent bit
- Setup Elasticsearch
- Setup Grafana

# Build
1. Start minikube
```bash
minikube start  --cpus 4 --memory 12192 -v 9 --disk-size 60G
```
2. Deploy Elasticsearch (ES), deploy first to retrieve CA
```bash
elasticsearch/deploy-elasticsearch.sh
```
Script will output ES password, save for later.
```bash
ES Password is Ehx0HE06B260iSCEA0689kub
```
- Create truststore for Jenkins from ES endpoint
ssl/create-pkcs12.sh

3. Deploy Jenkins
```bash
jenkins/deploy-jenkins.sh
```
Script will output Jenkins initial password:
```bash
Sun Mar 24 08:18:38 EDT 2024 Jenkins init password
830ef00dd5744bf3933d3fe13f62b864
```
Install `stress` etc on Jenkins pod
```bash
docker exec -it minikube /bin/bash
# get pod iamge id
docker ps | grep jenkins
# login with ID
docker exec -t -i --user root 759e896e4ffe /bin/bash
apt-get update -y
apt-get install stress -y
apt-get install vim -y
apt-get install inotify-tools -y
# install logstash - WIP 
apt-get install wget -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list
apt-get update && apt-get install logstash
apt-get install logstash -y
chmod -R 777 /
```