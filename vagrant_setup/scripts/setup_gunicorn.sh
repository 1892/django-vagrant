#!/usr/bin/env bash

. /vagrant/vagrant_setup/config.txt


sudo touch /etc/systemd/system/$APP_NAME-gunicorn.service

cat > /etc/systemd/system/$APP_NAME-gunicorn.service << EOF1
[Unit]
Description=$APP_NAME gunicorn daemon
After=network.target

[Service]
User=$APP_USER
Group=www-data
WorkingDirectory=/home/$APP_USER/$APP_NAME
ExecStart=/home/$APP_USER/$APP_NAME/.venv/bin/gunicorn --access-logfile - --workers 3 --bind unix:/home/$APP_USER/$APP_NAME.sock $APP_NAME.wsgi:application

[Install]
WantedBy=multi-user.target
EOF1

sudo systemctl start gunicorn
sudo systemctl enable gunicorn

sudo systemctl status gunicorn

ls /home/$APP_USER/$APP_NAME