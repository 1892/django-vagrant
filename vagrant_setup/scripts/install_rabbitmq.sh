#!/usr/bin/env bash

. /vagrant/vagrant_setup/config.txt

wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb

sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install -y erlang erlang-nox

echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y rabbitmq-server


systemctl enable rabbitmq-server
 
# To start the service:
systemctl start rabbitmq-server

sudo rabbitmqctl add_user $APP_DB_USER $APP_USER_PASS 

sudo rabbitmqctl set_user_tags $APP_DB_USER administrator

sudo rabbitmqctl set_permissions -p / $APP_DB_USER ".*" ".*" ".*"

sudo rabbitmq-plugins enable rabbitmq_management
sudo rm -rf erlang-solutions_1.0_all.deb