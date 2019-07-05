#!/bin/bash

sudo apt-get update
sudo apt -y install docker.io
sudo apt-get -y install docker-compose
sudo apt-get -y install git-core
sudo apt -y install python3-pip
sudo pip3 install elasticsearch
cd /tmp
sudo git clone https://github.com/deviantony/docker-elk.git
cd /tmp/docker-elk/
#sudo docker-compose up
