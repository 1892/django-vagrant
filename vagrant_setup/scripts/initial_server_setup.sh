#!/usr/bin/env bash
. /vagrant/vagrant_setup/config.txt

#Create user
sudo useradd -p $APP_USER_PASS -m $APP_USER

sudo usermod -aG sudo $APP_USER

sudo su - $APP_USER

# sudo chown $APP_USER /home/$APP_USER
# # Give write permission to app user
# sudo chown -R $APP_USER:$APP_USER /home/$APP_USER

sudo apt-get update

sudo apt-get install -y python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx