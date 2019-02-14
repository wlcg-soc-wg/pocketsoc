#! /bin/bash

scale=$1

logfile="log/pocketsoc_run.log"

./configure.sh

echo "Starting up, see $logfile"
/usr/local/bin/docker-compose up --remove-orphans --scale apache=$scale > $logfile 2>&1 &
