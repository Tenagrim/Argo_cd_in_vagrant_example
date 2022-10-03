The purpose of the project is to become more familiar with \
Kubernetes (k3s, k3d) and AgroCD.

All three parts (p1, p2, p3) are based on Vagrant environments \
with VirtualBox as hypervisor.

p1:\
 In this task just two virtual machines were configured, \
 there are two nodes of k3s connected to single cluster. 

p2:\
 One machine with k3s and three simple applications

p3:\
   One machine with k3d cluster and AgroCD inside, configured to \
 automatically apply configuration on cluster once it was modified \
 inside the [git repo](https://github.com/Tenagrim/gshona_config) .

Prerequisites: \
-- be sure if your system supports virtualization on cpu \
-- install VirtualBox \
-- install Vagrant \
-- run: "vagrant plugin install vagrant-vbguest --plugin-version 0.21" \
-- enter your docker hub creds in p1/config/registries.yaml (optional) \
-- run: "vagrant up" inside p1, p2 or p3 directory  \
-- for p3 it needs to ssh inside vm and run scripts: \
   "/vagrant/scripts/install.sh"     to install necessary stuff
   then relogin with ssh or use "su vagrant" to apply docker group to user
   "/vagrant/scripts/deploy.sh"      to create k3d cluster, deploy ArgoCD and simple application with it.