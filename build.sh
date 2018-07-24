#! /bin/bash

docker network create --subnet 172.18.0.0/16 internal
docker network create --subnet 172.19.0.0/16 external
docker network create --subnet 172.20.0.0/16 mirror

mkdir -p ./misp-data/{misp,mysql}

docker-compose build
docker-compose up
