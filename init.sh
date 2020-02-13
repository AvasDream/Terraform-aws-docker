#!/bin/bash
# Install Docker
apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
# Allow remote connections
mkdir -p /etc/systemd/system/docker.service.d
echo "ExecStart=/usr/bin/dockerd -H unix:// -H tcp://0.0.0.0:2375" >> /etc/systemd/system/docker.service.d/options.conf
systemctl daemon-reload
systemctl restart docker