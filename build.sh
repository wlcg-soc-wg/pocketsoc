#! /bin/bash

# Prep submodules

git submodule update --init

# Create networks

./tools/build-networks.sh

# Configure logstash pipeline(s) and MISP

./configure.sh

# Build and bring up containers

docker-compose build
docker-compose up
