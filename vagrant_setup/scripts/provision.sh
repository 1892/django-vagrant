#!/usr/bin/env bash

# This script is calling directly from the Vagrantfile and sets up
# Ubuntu 14.04 server with: 
#  - Python2.7 & Python3.6
#  - Django
#  - Git
#  - Gunicorn
#  - Nginx
#  - PostgreSQL
#  - Fabric
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