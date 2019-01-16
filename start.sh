#! /bin/bash

logfile="log/pocketsoc_run.log"

./configure.sh

echo "Starting up, see $logfile"
docker-compose up > $logfile 2>&1 &
