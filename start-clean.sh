#! /bin/bash

logfile="log/pocketsoc_run.log"

./configure.sh

echo "Closing existing run"
docker-compose stop

echo "Starting up, see $logfile"
docker-compose up > $logfile 2>&1 &

echo "Cleaning elasticsearch"
./tools/revert-elasticsearch.sh
