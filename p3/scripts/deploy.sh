#!/bin/bash

clustername=dev-cluster
k3d cluster create "${clustername}" \
  --k3s-arg '--flannel-backend=none@server:*' \
  --volume "/config/calico.yaml:/var/lib/rancher/k3s/server/manifests/calico.yaml"

#k3d cluster create dev-cluster   --port 8080:80@loadbalancer --port 8888:8888@loadbalancer --port 8443:443@loadbalancer

# ###############################################################
# Argo CD install:
# Ref: https://argo-cd.readthedocs.io/en/stable/getting_started/

kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.12/manifests/install.yaml
# latest at 01.10.2022: https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.12/manifests/install.yaml

echo "[DEBUG] Wait for all argocd pods is up..."
sleep 10
kubectl wait --for=condition=Ready --timeout=-1s  pods --all -n argocd
# ###########
# Ingress:
# Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/

kubectl apply -n argocd -f /vagrant/config/argocd_ingress.yaml
kubectl apply -n argocd -f /vagrant/config/argocd_application_deploy.yaml

while ! kubectl get secret argocd-initial-admin-secret >/dev/null 2>/dev/null  -n argocd; do echo "Waiting for password. CTRL-C to abort."; sleep 10; done
echo "PASSWORD:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

echo "[DEBUG] Wait for all dev pods is up..."
kubectl wait --for=condition=Ready --timeout=-1s  pods --all -n argocd

nohup bash -c "while true; do kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8090:443; sleep 10; done &"
nohup bash -c "while true; do kubectl port-forward --address 0.0.0.0 svc/will-playground-service -n dev 8888:8888; sleep 10; done &"


