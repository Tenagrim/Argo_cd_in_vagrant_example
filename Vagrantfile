# -*- mode: ruby -*-
# vi: set ft=ruby :

MASTER_NAME = 'gshonaS'
MASTER_IP = '192.168.42.110'

WORKER_NAME = 'gshonaSW'
WORKER_IP = '192.168.42.111'

VM_MEMORY =  "1024"
VM_CPUS = 1

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  #config.vm.box_url = ""

  config.vm.define MASTER_NAME do |control|
    control.vm.hostname = MASTER_NAME
    control.vm.network :private_network, ip: MASTER_IP
    control.vm.synced_folder ".", "/vagrant", type: "virtualbox"
    #control.vm.synced_folder ".", "/vagrant", disabled: false
    control.vm.provision :shell, privileged: true, path: "scripts/provision_server.sh", args: [MASTER_IP]
    control.vm.provider "virtualbox" do |v|
      #v.customize ["modifyvm", :id, "--name", "wilS"]
      v.name = MASTER_NAME
      v.gui = false
      v.memory = VM_MEMORY
      v.cpus = VM_CPUS
    end
  end


    config.vm.define WORKER_NAME do |control|
      control.vm.hostname = WORKER_NAME
      control.vm.network :private_network, ip: WORKER_IP
      control.vm.synced_folder ".", "/vagrant", type: "virtualbox"
      control.vm.provision :shell, privileged: true, path: "scripts/provision_worker.sh", args: [MASTER_IP, WORKER_IP]
      control.vm.provider "virtualbox" do |v|
        v.name = WORKER_NAME
        v.gui = false
        v.memory = VM_MEMORY
        v.cpus = VM_CPUS
      end
    end

end
