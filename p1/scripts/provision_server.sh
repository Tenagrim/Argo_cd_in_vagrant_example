#!/bin/bash

export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $1 --node-ip $1  --bind-address=$1 --advertise-address=$1"
[ -f '/vagrant/node-token' ] && rm '/vagrant/node-token'
sudo yum install net-tools -y
curl -sfL https://get.k3s.io | sh -
sudo mkdir -p /etc/rancher/k3s
sudo cp /vagrant/config/registries.yaml /etc/rancher/k3s/registries.yaml
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant
