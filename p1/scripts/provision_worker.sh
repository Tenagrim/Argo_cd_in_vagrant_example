#!/bin/bash

export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file /vagrant/node-token --node-ip=$2"
curl -sfL https://get.k3s.io | sh -
sudo mkdir -p /etc/rancher/k3s
sudo yum install net-tools -y
sudo cp /vagrant/config/registries.yaml /etc/rancher/k3s/registries.yaml

