#!/usr/bin/env bash

. /vagrant/vagrant_setup/config.txt

sudo touch /etc/nginx/sites-available/$APP_NAME

cat > /etc/nginx/sites-available/$APP_NAME << EOF2
server {
    listen 80;
    server_name $APP_SERVER;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/$APP_USER/$APP_NAME;
    }

    location /media/ {
        root /home/$APP_USER/$APP_NAME;
    }

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/$APP_USER/$APP_NAME/$APP_NAME.sock;
    }
}
EOF2

sudo ln -s /etc/nginx/sites-available/$APP_NAME /etc/nginx/sites-enabled

sudo nginx -t

sudo systemctl restart nginx

sudo apt-get install ufw
sudo ufw delete allow 8000