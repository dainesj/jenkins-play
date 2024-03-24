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
```bash
ssl/create-pkcs12.sh
```

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
- Login to Jenkins using save passwword and add plugins:
- Add logstash plugin, configure with URL:
```BASH
https://elasticsearch-es-internal-http.devops-tools.svc:9200/jenkin_index/_doc
# JVM Truststore was configured during deployment 
```
![Logstasch Jenkins Configure](ssl/configure-logstash.jpeg)

- Add Build timestamp plugin
- Configure a job using content from `jenkins/jenkins-build-script.sh`
4. Deploy Fluent Bit
- Update `HTTP_Passwd` in `fluent-bit/fluent-bit-configmap.yaml` to the ES password
- Deploy Fluent Bit
```bash
fluent-bit/deploy-fluentbit.sh
```
5. Deploy Grafana
```bash
grafana/deploy-grafana.sh
```
- Login to grafana with user `admin` and password `admin`
- Configure datasource for Jenkins indeces
- Configure datasource for CPU indeces
```bash
# Use URL
https://elasticsearch-es-internal-http.devops-tools.svc.cluster.local:9200

# add Basic Auth
User = elastic
Password = use ES password from previous output
# Toggle "Skip TLS certificate validation"
```