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

clustername=dev-cluster
k3d cluster create "${clustername}" \
  --k3s-arg '--flannel-backend=none@server:*' \
  --volume "/config/calico.yaml:/var/lib/rancher/k3s/server/manifests/calico.yaml"

#k3d cluster create dev-cluster   --port 8080:80@loadbalancer --port 8888:8888@loadbalancer --port 8443:443@loadbalancer

sudo cp -r /root/.kube /home/vagrant
sudo chown 1000:1000 /home/vagrant/.kube
sudo chown 1000:1000 /home/vagrant/.kube/config
sudo chmod 666 /home/vagrant/.kube/config

# ###############################################################
# Argo CD install:
# Ref: https://argo-cd.readthedocs.io/en/stable/getting_started/

kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.12/manifests/install.yaml
# latest at 01.10.2022: https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.12/manifests/install.yaml

kubectl wait --for=condition=Ready --timeout=-1s  pods --all -n argocd
# ###########
# Ingress:
# Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/

kubectl apply -n argocd -f /vagrant/config/argocd_ingress.yaml
kubectl apply -n argocd -f /vagrant/config/argocd_application_deploy.yaml

while ! kubectl get secret argocd-initial-admin-secret >/dev/null 2>/dev/null  -n argocd; do echo "Waiting for password. CTRL-C to abort."; sleep 10; done
echo "PASSWORD:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

#while true; do kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8090:443; sleep 10; done &
#while true; do kubectl port-forward --address 0.0.0.0 svc/will-playground-service -n dev 8888:8888; sleep 10; done &


