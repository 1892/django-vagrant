#!/usr/bin/env bash

. /vagrant/vagrant_setup/config.txt

sudo cp -i -r -n /home/$APP_USER/$APP_NAME/ $VAGRANT_APP_BACKUP_PATH/