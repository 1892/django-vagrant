#!/usr/bin/env bash

# This script is calling directly from the Vagrantfile and sets up
# Ubuntu 16.04 server with:
#  - Python2.7 & Python3.6
#  - Django
#  - Git
#  - Gunicorn
#  - Nginx
#  - PostgreSQL
#  - Fabric
#  - ElasticSearch
#  - Rabbitmq
# It also creates a database for the project
# and a user that can access it.

# GET APP VARIABLES FROM CONFIG FILE
. /vagrant/vagrant_setup/config.txt

# SETTING UP DJANGO
source $VAGRANT_SCRIPT_PATH/initial_server_setup.sh

# CREATE DB
source $VAGRANT_SCRIPT_PATH/create_db.sh

# CREATE PROJECT

source $VAGRANT_SCRIPT_PATH/create_project.sh

source $VAGRANT_SCRIPT_PATH/setup_gunicorn.sh

source $VAGRANT_SCRIPT_PATH/setup_nginx.sh

source $VAGRANT_SCRIPT_PATH/sync_folder.sh

source $VAGRANT_SCRIPT_PATH/install_redis.sh

read -p "Do you want to install rabbitmq? " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    $VAGRANT_SCRIPT_PATH/install_rabbitmq.sh
fi

read -p "Do you want to install elasticsearch? " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    $VAGRANT_SCRIPT_PATH/search_engine.sh
fi

read -p "Do you want to install mongodb? " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    $VAGRANT_SCRIPT_PATH/install_mongodb.sh
fi

read -p "Will you use celery?" -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    $VAGRANT_SCRIPT_PATH/setup_celery.sh
fi
