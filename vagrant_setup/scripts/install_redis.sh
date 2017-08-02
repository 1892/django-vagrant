#!/usr/bin/env bash

. /vagrant/vagrant_setup/config.txt

sudo apt-get update
sudo apt-get install -y build-essential tcl

cd /tmp

sudo apt-get install -y curl

curl -O http://download.redis.io/redis-stable.tar.gz

tar xzvf redis-stable.tar.gz

rm -rf redis-stable.tar.gz

cd redis-stable

make

make test

sudo make install

sudo mkdir /etc/redis

sudo cp /tmp/redis-stable/redis.conf /etc/redis

touch /etc/redis/redis.conf

cat > /etc/redis/redis.conf << EOF4
# If you run Redis from upstart or systemd, Redis can interact with your
# supervision tree. Options:
#   supervised no      - no supervision interaction
#   supervised upstart - signal upstart by putting Redis into SIGSTOP mode
#   supervised systemd - signal systemd by writing READY=1 to $NOTIFY_SOCKET
#   supervised auto    - detect upstart or systemd method based on
#                        UPSTART_JOB or NOTIFY_SOCKET environment variables
# Note: these supervision methods only signal "process is ready."
#       They do not enable continuous liveness pings back to your supervisor.
supervised systemd
EOF4

touch /etc/systemd/system/redis.service

cat > /etc/systemd/system/redis.service << EOF5
[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
EOF5

sudo adduser --system --group --no-create-home redis

sudo mkdir /var/lib/redis

sudo chown redis:redis /var/lib/redis

sudo chmod 770 /var/lib/redis

sudo systemctl start redis