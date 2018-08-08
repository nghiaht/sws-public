#!/bin/sh

echo "=> Provision Vagrant box"

echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf

# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository
# https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user
# https://docs.docker.com/compose/install/

sudo apt-get update -y
sudo apt-get install -y linux-headers-$(uname -r) build-essential dkms
sudo apt-get install -y wget

echo "==> Install Docker"

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -y
sudo apt-get install -y docker-ce
sudo docker run hello-world

sudo groupadd docker
sudo usermod -aG docker $USER
sudo usermod -aG docker ubuntu
sudo usermod -aG docker vagrant
docker run hello-world

echo "==> Install Docker Compose"

sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
