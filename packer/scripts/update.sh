#! /bin/env/bash

# Update the box
mkdir -p /etc/apt/
if [ -a "/etc/apt/sources.list" ]; then
    mv /etc/apt/sources.list /etc/apt/sources.list.backup
fi

(
    cat <<EOF
deb http://deb.debian.org/debian bullseye main
deb-src http://deb.debian.org/debian bullseye main

deb http://deb.debian.org/debian-security/ bullseye-security main
deb-src http://deb.debian.org/debian-security/ bullseye-security main

deb http://deb.debian.org/debian bullseye-updates main
deb-src http://deb.debian.org/debian bullseye-updates main

deb [arch=amd64] http://download.proxmox.com/debian/pve bullseye pve-no-subscription
deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable
deb http://apt.kubernetes.io/ kubernetes-xenial main

EOF
) >/etc/apt/sources.list
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
apt update -y
apt full-upgrade -y