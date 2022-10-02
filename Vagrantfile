# -*- mode: ruby -*-
# vi: set ft=ruby :

MASTER_NAME = 'p3-gshonaS'
MASTER_IP = '192.168.42.110'
VM_MEMORY =  "2048"
VM_CPUS = 2

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  #config.vm.box_url = ""

  config.vm.define MASTER_NAME do |control|
    control.vm.hostname = MASTER_NAME
    control.vm.network :private_network, ip: MASTER_IP
    control.vm.network :forwarded_port, host: 8080, guest: 8080
    control.vm.network :forwarded_port, host: 8888, guest: 8888
    control.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    control.vm.provision :shell, privileged: true, path: "scripts/provision_server.sh", args: [MASTER_IP]
    control.vm.provider "virtualbox" do |v|
      v.name = MASTER_NAME
      v.gui = false
      v.memory = VM_MEMORY
      v.cpus = VM_CPUS
    end
  end

end
