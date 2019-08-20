#!/bin/bash
apt-get update
apt install curl git jq sudo -y

mkdir -p ~/.jx/bin 
curl -L https://github.com/jenkins-x/jx/releases/download/v2.0.598/jx-linux-amd64.tar.gz |tar xzv -C ~/.jx/bin  
export PATH=$PATH:~/.jx/bin 

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
apt-get install apt-transport-https ca-certificates -y

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
apt-get update && apt-get install google-cloud-sdk -y

gcloud init

PROJECT=jx-01-226119

jx create cluster gke \
--cluster-name jx-rocks \
--skip-login \
--project-id $PROJECT \
--region us-east1 \
--machine-type n1-standard-1 \
--min-num-nodes 1 \
--max-num-nodes 2 \
--default-admin-password jx-rox-19 \
--default-environment-prefix jx-rocks

token = 3894d0951b4f932a2a59069d563f21c724696d4c