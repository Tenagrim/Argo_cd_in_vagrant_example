# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  #config.vm.box_url = ""

  config.vm.define "gshonaS" do |control|
    control.vm.hostname = "gshonaS"
    control.vm.network :private_network, ip: "192.168.42.110"
    control.vm.provider "virtualbox" do |v|
      #v.customize ["modifyvm", :id, "--name", "wilS"]
      v.name = "gshonaS"
      v.gui = false
      v.memory = "512"
      v.cpus = 1
    end
  config.vm.provision :shell, path: "provision_server.sh"
  end
end
