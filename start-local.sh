#! /bin/bash

SOCDIR=`pwd`

scale=$1

logfile=$SOCDIR"/log/run.log"

$SOCDIR/configure.sh $SOCDIR

echo "Starting up, see $logfile"

cd $SOCDIR

/usr/local/bin/docker-compose up --remove-orphans --scale apache=$scale > $logfile 2>&1 &
