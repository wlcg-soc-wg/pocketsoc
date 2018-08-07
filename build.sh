#! /bin/bash

# Prep submodules

git submodule update --init

# Create networks

docker network create --subnet 172.18.0.0/16 internal
docker network create --subnet 172.19.0.0/16 external
docker network create --subnet 172.20.0.0/16 mirror

# Clean MISP data

rm -rf ./misp-data
mkdir -p ./misp-data/{misp,mysql}

# Configure logstash pipeline(s) and MISP

./configure.sh

# Build and bring up containers

docker-compose build
docker-compose up
