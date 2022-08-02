#! /bin/env/bash

if [ ${SERVER+x} ];
then
    echo "CONFIGURING SERVER"
    systemctl enable rke2-server.service
    systemctl start rke2-server.service
else
    echo "CONFIGURING AGENT"
    systemctl enable rke2-agent.service
    mkdir -p /etc/rancher/rke2/
    ( 
cat <<EOF
server: https://<server>:9345
token: <token from server node>

EOF
    ) > /etc/racher/rke2/config.yaml
    systemctl start rke2-agent.service
fi