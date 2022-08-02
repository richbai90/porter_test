#! /bin/env/bash

export DEBIAN_FRONTEND=noninteractive
# Update repos
apt-get update -y
# install Docker
apt-get install -y docker-ce docker-ce-cli containerd.io apparmor-parser
# install rke2
if [ ${SERVER+x} ];
then
    echo "INSTALLING SERVER"
    curl -sfL https://get.rke2.io | DEBUG=1 sh -
else
    echo "INSTALLING AGENT"
    curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
fi