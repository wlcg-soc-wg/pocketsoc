#! /bin/bash

source /config/setauth.sh

FEEDDIR="/config/feeds"
FEEDFILE=$FEEDDIR"/testdata.txt"

mkdir -p $FEEDDIR

touch $FEEDFILE
AUTH_KEY="Authorization: $AUTHKEY"

curl -k -s --header "$AUTH_KEY" https://172.20.0.20/attributes/bro/download/ > $FEEDFILE
