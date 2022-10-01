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

k3d cluster create dev-cluster --port 8080:80@loadbalancer --port 8888:8888@loadbalancer --port 8443:443@loadbalancer


# ###############################################################
# Argo CD install:
# Ref: https://argo-cd.readthedocs.io/en/stable/getting_started/

kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.0.1/manifests/install.yaml

#kubectl wait --for=condition=Ready --timeout=-1s  pods --all -n argocd

# ###########
# Ingress:
# Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/

kubectl apply -n argocd -f /vagrant/config/argocd_ingress.yaml
kubectl apply -n argocd -f /vagrant/config/argocd_application_deploy.yaml

# latest at 01.10.2022: https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.12/manifests/install.yaml
