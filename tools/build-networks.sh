#! /bin/bash

docker network ls | grep -q internal

if [ $? -ne 0 ]; then
    docker network create --subnet 172.18.0.0/16 internal
fi

docker network ls | grep -q external

if [ $? -ne 0 ]; then
    docker network create --subnet 172.19.0.0/16 external
fi

docker network ls | grep -q mirror

if [ $? -ne 0 ]; then
    docker network create --subnet 172.20.0.0/16 mirror
fi
