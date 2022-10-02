#!/bin/bash

export PATH=$PATH:/usr/local/bin
sudo yum install net-tools -y

# ###############################################################
# Docker installtion:
# Ref:  https://docs.docker.com/engine/install/centos/

sudo yum install -y yum-utils
sudo yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
#sudo groupadd docker
sudo usermod -aG docker vagrant
sudo systemctl start docker

# ###############################################################
# Kubectl install
# Ref: https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
chmod +x ./kubectl && \
sudo mv ./kubectl /usr/local/bin/kubectl

# ###############################################################
# K3D install
# Ref: https://k3d.io/v5.4.6/

curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# ###############################################################
# K3D cluster
# ########################
# Calico Instead of Flanel
# Ref: https://k3d.io/v5.3.0/usage/advanced/calico/

sudo mkdir -p /config
curl -O https://k3d.io/v5.3.0/usage/advanced/calico.yaml
sudo mv calico.yaml /config