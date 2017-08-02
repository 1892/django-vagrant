#!/usr/bin/env bash

. /vagrant/vagrant_setup/config.txt

# create folder

cd /home/$APP_USER

mkdir $APP_NAME
cd $APP_NAME

sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv

# create virtaulenv
virtualenv .venv

source .venv/bin/activate

# install some require lib
pip3 install django gunicorn psycopg2

django-admin.py startproject $APP_NAME .

deactivate
