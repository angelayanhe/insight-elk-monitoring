#!/bin/bash

postgres=$1
sparkmaster=$2
#nyears=$3

APPHOME='/home/ubuntu/insight-monitoring-poc/AirAware'

# Install dependencies
sudo pip install configparser
sudo pip --no-cache-dir install pyspark

# Install Git and clone repo
sudo apt-get install git-core
git clone https://github.com/angelayanhe/insight-elk-monitoring.git

# Configure setup.cfg with Postgres and Spark master private DNS
sed -i "/dns-postgres/c\dns = ${postgres}" ${APPHOME}/setup.cfg
sed -i "/dns-spark/c\dns = ${sparkmaster}:7077" ${APPHOME}/setup.cfg
