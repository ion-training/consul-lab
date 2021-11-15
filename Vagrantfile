# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.define "server" do |server|
    server.vm.hostname = "server"
    server.vm.provision "shell", path: "scripts/server.sh"
    server.vm.network "private_network", ip: "192.168.56.70"
  end

  config.vm.define "client1" do |client1|
    client1.vm.hostname = "client1"
    client1.vm.provision "shell", path: "scripts/client1.sh"
    client1.vm.network "private_network", ip: "192.168.56.71"
  end

  config.vm.define "client2" do |client2|
    client2.vm.hostname = "client2"
    client2.vm.provision "shell", path: "scripts/client2.sh"
    client2.vm.network "private_network", ip: "192.168.56.72"
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
end
