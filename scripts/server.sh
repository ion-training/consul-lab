#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# pre-reqs
apt-get update
apt-get install -y zip unzip

# hashicorp apt repo
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install consul
apt-get update
apt-get install consul

# create directories
mkdir --parents /etc/consul.d
chown --recursive consul:consul /etc/consul.d
chmod 640 /etc/consul.d/consul.hcl

# copy service config
cp -ap /vagrant/conf/consul.service /usr/lib/systemd/system/consul.service

# copy consul config
cp -ap /vagrant/conf/server/consul.hcl /etc/consul.d/
chown -R consul: /etc/consul.d /opt/consul/

# consul set bash env
cp -ap /vagrant/conf/consul-bash-env.sh /etc/profile.d/

systemctl enable consul
systemctl start consul
