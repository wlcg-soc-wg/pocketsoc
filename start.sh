#! /bin/bash

scale=$1

logfile="log/pocketsoc_run.log"

./configure.sh

echo "Starting up, see $logfile"
/usr/local/bin/docker-compose up --scale apache=$scale > $logfile 2>&1 &
