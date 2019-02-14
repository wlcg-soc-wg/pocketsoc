#! /bin/bash

scale=$1

logfile=$SOCDIR"/log/build.log"

$SOCDIR/configure.sh

echo "Starting up, see $logfile"

cd $SOCDIR

/usr/local/bin/docker-compose build  2>&1 | tee $logfile
