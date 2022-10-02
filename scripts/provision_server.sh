#!/bin/bash

export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $1 --node-ip $1  --bind-address=$1 --advertise-address=$1"
[ -f '/vagrant/node-token' ] && rm '/vagrant/node-token'
sudo yum install net-tools -y
curl -sfL https://get.k3s.io | sh -
sudo mkdir -p /etc/rancher/k3s
export PATH=$PATH:/usr/local/bin

kubectl create configmap app1-cfg --from-file /vagrant/src/app1/index.html
kubectl apply -f /vagrant/src/app1/deployment.yaml
kubectl apply -f /vagrant/src/app1/service.yaml
kubectl apply -f /vagrant/src/app1/ingress.yaml

kubectl create configmap app2-cfg --from-file /vagrant/src/app2/index.html
kubectl apply -f /vagrant/src/app2/deployment.yaml
kubectl apply -f /vagrant/src/app2/service.yaml
kubectl apply -f /vagrant/src/app2/ingress.yaml

kubectl create configmap app3-cfg --from-file /vagrant/src/app3/index.html
kubectl apply -f /vagrant/src/app3/deployment.yaml
kubectl apply -f /vagrant/src/app3/service.yaml
kubectl apply -f /vagrant/src/app3/ingress.yaml