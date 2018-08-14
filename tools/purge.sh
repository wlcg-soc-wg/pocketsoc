#! /bin/bash

docker-compose down

docker image ls | egrep "misp|demo" | awk '{print $3}' | xargs -n1 -t -I {} docker image rm -f {}

tools/clean-volumes.sh
