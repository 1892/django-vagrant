#!/usr/bin/env bash

# Prerequisites
# Before following this tutorial, you will need:

# Installing the Oracle JDK
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update


sudo apt-get install oracle-java8-installer

sudo update-alternatives --config java

sudo update-alternatives --config command


sudo update-alternatives --config java

sudo nano /etc/environment


cat > /etc/environment << EOF
JAVA_HOME="/usr/lib/jvm/java-8-oracle"
EOF

source /etc/environment

echo $JAVA_HOME


# Step 2: Downloading and Installing Elasticsearch

sudo apt-get update

echo "Installing ElasticSearch"

wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb

sudo dpkg -i elasticsearch-1.7.2.deb

sudo systemctl enable elasticsearch

sudo systemctl start elasticsearch

sudo rm -rf elasticsearch-1.7.2.deb