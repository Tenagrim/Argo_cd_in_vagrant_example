#!/bin/bash

export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip $1  --bind-address=$1 --advertise-address=$1 "
#export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file $TOKEN_FILE --node-ip=$2"

curl -sfL https://get.k3s.io | sh -
sudo cp /vagrant/config/registries.yaml /etc/rancher/k3s/registries.yaml
#sudo chmod +r /etc/rancher/k3s/k3s.yaml
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant
