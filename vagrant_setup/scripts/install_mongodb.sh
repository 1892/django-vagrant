#!/usr/bin/env bash

# Ubuntu ensures the authenticity of software packages by verifying that they are signed with GPG keys,
# so we first have to import they key for the official MongoDB repository

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

sudo apt-get update

sudo apt-get install -y mongodb-org

sudo systemctl start mongod


# The last step is to enable automatically starting MongoDB when the system starts.
sudo systemctl enable mongod

sudo systemctl restart mongod