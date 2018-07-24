#! /bin/bash

docker-compose down

docker network rm internal
docker network rm external
docker network rm mirror
