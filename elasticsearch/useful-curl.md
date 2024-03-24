##############################################################################################################################################################
# ELASTICSEARCH SECTION

# refresh index
curl -k -X POST -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_refresh

# Retrieve a few recent documents to check their timestamps:
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_search?sort=@timestamp:desc&pretty

# Jenkins Index
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_search?pretty -H 'Content-Type: application/json' -d'
{
  "query": {
    "match_all": {}
  }
}'


# check Check Cluster and Index Health:
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/_cluster/health?pretty
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/_cat/indices?v

# Check the refresh interval for your index:
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_settings?pretty

# reduce the refresh interval for testing:
curl -k -X PUT -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_settings -H 'Content-Type: application/json' -d'
{
  "index" : {
      "refresh_interval" : "1s"
  }
}'


#############################################################################################################################################################################################################################################
kubectl exec -it elasticsearch-es-default-0 -- curl -X GET "http://localhost:9200/jenkins-logs-*/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match_all": {}
  },
  "sort": [
    {
      "@timestamp": {
        "order": "desc"
      }
    }
  ],
  "size": 5
}
'

kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/logstash.yml

# get elastic login password
kubectl get secrets elasticsearch-es-elastic-user -o jsonpath='{.data.elastic}' | base64 -D 

# check in browser
https://0.0.0.0:9200/_cat/indices

# produce 
curl -k -XPOST "https://localhost:9200/my_index/_doc" -H "Content-Type: application/json" -d '{"name": "John", "age": 30}' -u elastic:HJ33w99JSU3119Ug22OcWSav

curl -k -XPOST "https://elasticsearch-es-internal-http.devops-tools.svc.cluster.local:9200/my_index/_doc" -H "Content-Type: application/json" -d '{"name": "John", "age": 30}' -u elastic:HJ33w99JSU3119Ug22OcWSav
{"_index":"my_index","_type":"_doc","_id":"1mlnZY4BBD-7-Dy_EAuN","_version":1,"result":"created","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":2,"_primary_term":1}j



export ES_URL="-u elastic:HJ33w99JSU3119Ug22OcWSav https://elasticsearch-es-internal-http.devops-tools.svc.cluster.local:9200"
# get indeces
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/_cat/indices?v

curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav http://localhost:9200/_cluster/state?pretty

```bash
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/_cat/indices\?v
health status index               uuid                   pri rep docs.count docs.deleted store.size pri.store.size
yellow open   logstash-2024.03.22 Kjrl5S4zRHGXQoYoLIYvSg   1   1          3            0     29.5kb         29.5kb

```
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav http://localhost:9200/_cluster/state?pretty


curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/logstash-2024.03.23/_search?pretty -H 'Content-Type: application/json' -d'
{
  "query": {
    "match_all": {}
  }
}'

# Jenkins Index
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_search?pretty -H 'Content-Type: application/json' -d'
{
  "query": {
    "match_all": {}
  }
}'


# check Check Cluster and Index Health:
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/_cluster/health?pretty
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/_cat/indices?v

# Check the refresh interval for your index:
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_settings?pretty

# reduce the refresh interval for testing:
curl -k -X PUT -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_settings -H 'Content-Type: application/json' -d'
{
  "index" : {
      "refresh_interval" : "1s"
  }
}'

# refresh index
curl -k -X POST -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_refresh

# Retrieve a few recent documents to check their timestamps:
curl -k -X GET -u elastic:HJ33w99JSU3119Ug22OcWSav https://localhost:9200/jenkin_index/_search?sort=@timestamp:desc&pretty


