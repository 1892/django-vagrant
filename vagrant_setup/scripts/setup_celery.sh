#!/usr/bin/env bash

. /vagrant/vagrant_setup/config.txt

sudo mkdir /etc/conf.d

sudo touch /etc/conf.d/$APP_NAME-celery

cat > /etc/conf.d/$APP_NAME-celery << EOF1
# Name of nodes to start
# here we have a single node
CELERYD_NODES="w1"
# or we could have three nodes:
#CELERYD_NODES="w1 w2 w3"

# Absolute or relative path to the 'celery' command:
CELERY_BIN="/home/$APP_USER/$APP_NAME/.venv/bin/celery"

# App instance to use
# comment out this line if you don't use an app
CELERY_APP=$APP_NAME
# or fully qualified:
#CELERY_APP="proj.tasks:app"

# How to call manage.py
CELERYD_MULTI="multi"

# Extra command-line arguments to the worker
CELERYD_OPTS="--time-limit=300 --concurrency=8"

# - %n will be replaced with the first part of the nodename.
# - %I will be replaced with the current child process index
#   and is important when using the prefork pool to avoid race conditions.
CELERYD_PID_FILE="/home/$APP_USER/$APP_NAME.pid"
CELERYD_LOG_FILE="/home/$APP_USER/$APP_NAME/logs/%n%I.log"
CELERYD_LOG_LEVEL="INFO"
EOF1

touch /etc/systemd/system/$APP_NAME-celery.service

cat > /etc/systemd/system/$APP_NAME-celery.service << EOF2
[Unit]
Description=$APP_NAME Celery Service
After=network.target

[Service]
Type=forking
User=$APP_USER
Group=www-data
EnvironmentFile=-/etc/conf.d/$APP_NAME-celery
WorkingDirectory=/home/$APP_USER/$APP_NAME

ExecStart=/bin/sh -c '${CELERY_BIN} multi start ${CELERYD_NODES} \
  -A ${CELERY_APP} --pidfile=${CELERYD_PID_FILE} \
  --logfile=${CELERYD_LOG_FILE} --loglevel=${CELERYD_LOG_LEVEL}'
ExecStop=/bin/sh -c '${CELERY_BIN} multi stopwait ${CELERYD_NODES} \
  --pidfile=${CELERYD_PID_FILE}'
ExecReload=/bin/sh -c '${CELERY_BIN} multi restart ${CELERYD_NODES} \
  -A ${CELERY_APP} --pidfile=${CELERYD_PID_FILE} \
  --logfile=${CELERYD_LOG_FILE} --loglevel=${CELERYD_LOG_LEVEL}'

[Install]
WantedBy=multi-user.target
EOF2

sudo systemctl enable $APP_NAME-celery.service
sudo systemctl start $APP_NAME-celery.service

