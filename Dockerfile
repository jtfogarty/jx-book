#FROM ubuntu:16.04
FROM gashirar/theia-kubernetes:latest
#Install curl and jq
RUN sudo apt-get update -y && sudo apt-get install vim -y
RUN mkdir -p ~/.jx/bin 
RUN curl -L https://github.com/jenkins-x/jx/releases/download/v2.0.598/jx-linux-amd64.tar.gz |tar xzv -C ~/.jx/bin  
RUN echo 'export PATH=$PATH:~/.jx/bin' >> ~/.bashrc
RUN curl -L https://github.com/github/hub/releases/download/v2.12.3/hub-linux-amd64-2.12.3.tgz |tar xzv -C /tmp
RUN cp /tmp/hub-linux-amd64-2.12.3/bin/hub ~/.jx/bin
RUN rm -rf /tmp/hub-linux-amd64-2.12.3

RUN sudo echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN sudo apt-get install apt-transport-https ca-certificates -y

RUN sudo curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN sudo apt-get update && sudo apt-get install google-cloud-sdk -y
