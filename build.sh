#! /bin/bash

scale=$1

logfile="log/build.log"

./configure.sh

echo "Starting up, see $logfile"
/usr/local/bin/docker-compose build  2>&1 | tee $logfile
