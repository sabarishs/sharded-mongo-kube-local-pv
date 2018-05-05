
#!/bin/bash
printf "\n======Ensuring mongodb key file exists===========\n"
#CREATE MONGODB-KEYFILE WHICH WILL BE USED IN ALL MONGO NODES.
kubectl get secrets/mongodb-key
if [[ $? -ne 0 ]]
then
echo "*** mongodb-keyfile does not exist. Creating one..."
openssl rand -base64 741 > mongodb-keyfile
echo "Adding to kube secrets"
kubectl create secret generic mongodb-key --from-file=mongodb-keyfile
else
echo "mongodob-keyfile exists"
fi
