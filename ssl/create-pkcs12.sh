
echo | openssl s_client -showcerts -connect localhost:9200 | awk '/CERTIFICATE/{x=x+1;if(x%2==0){p=0;print}else{p=1}};{if(p){print}}' > ssl/truststore.pem

KEYSTORE=ssl/truststore.jks
KEYSTORE_PASSWORD=keystore_password


ssl/import_all.sh ssl/truststore.pem keystore_password ssl/truststore.jks
ssl/import_all.sh ssl/lets-encrypt.pem keystore_password ssl/truststore.jks


kubectl create secret generic jenkins-truststore-secret --from-file=truststore.jks=$KEYSTORE -n devops-tools



exit 

# Random notes

https://updates.jenkins.io

echo | openssl s_client -showcerts -connect updates.jenkins.io:443 | awk '/CERTIFICATE/{x=x+1;if(x%2==0){p=0;print}else{p=1}};{if(p){print}}' > archive/jenkins-truststore.pem

archive/import_all.sh archive/jenkins-truststore.pem keystore_password archive/truststore.jks

keytool -importkeystore -srckeystore ${KEYSTORE} -destkeystore out.p12 -srcstoretype jks -deststoretype pkcs12 -srcstorepass ${KEYSTORE_PASSWORD} -deststorepass ${KEYSTORE_PASSWORD}

keytool -genkey -keyalg RSA -alias deleteme -keystore archive/truststore.jks -storepass keystore_password


archive/import_all.sh archive/cert.pem keystore_password archive/truststore.jks

keytool -list -keystore /mnt/truststore.jks -storepass keystore_password

export KEYSTORE=archive/truststore.jks
kubectl delete -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/deployment.yaml
kubectl delete secret jenkins-truststore-secret
kubectl create secret generic jenkins-truststore-secret --from-file=truststore.jks=$KEYSTORE -n devops-tools
kubectl apply -f /Users/jdaines/tickets/299999-Jenkins/customer/03-20-2024/deployment.yaml

export POD_NAME=$(kubectl get pods | grep jenkins- | cut -d' ' -f1 ) ; echo $POD_NAME\nkubectl port-forward $POD_NAME 8080:8080 &\n
ps -ef | grep forw | grep -v grep



# quick rebuild
export KEYSTORE=ssl/truststore.jks
export KEYSTORE_PASSWORD=keystore_password
kubectl delete secret jenkins-truststore-secret 
kubectl create secret generic jenkins-truststore-secret --from-file=truststore.jks=$KEYSTORE -n devops-tools
