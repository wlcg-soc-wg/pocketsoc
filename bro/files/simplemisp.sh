#! /bin/bash

FEEDDIR="/files/feeds"
FEEDFILE=$FEEDDIR"/testdata.txt"

mkdir -p $FEEDDIR

touch $FEEDFILE
AUTH_KEY="Authorization: mpl2OY4GQ9YMIv4pb2jtLvlKX6HblKwl5m6AYkBM"

curl -s --header "$AUTH_KEY" http://172.20.0.20/attributes/bro/download/ > $FEEDFILE
