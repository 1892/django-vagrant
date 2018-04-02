#!/usr/bin/env bash

. vagrant_setup/config.txt

APP_SERVER=$APP_SERVER
APP_USER=$APP_USER
APP_NAME=$APP_NAME

touch Vagrantfile

cat > Vagrantfile << EOF3
Vagrant.configure(2) do |config|
  config.vm.network :forwarded_port, host: 1338, guest: 80

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.define "web" do |web|
     web.vm.box = "bento/ubuntu-16.04"
     web.vm.hostname = "web"
     web.vm.network "private_network", ip: "$APP_SERVER"
     web.vm.provision :shell, path: "vagrant_setup/scripts/provision.sh"
     # web.vm.synced_folder "$APP_NAME/", "/home/$APP_USER/$APP_NAME", owner: "$APP_USER", group: "users"
  end

end
EOF3

vagrant up
