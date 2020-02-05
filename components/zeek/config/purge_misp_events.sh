#! /bin/bash

source /config/setauth.sh

events=`curl -s -k --header "Authorization: $AUTHKEY" --header "Accept: application/json" --header "Content-Type: application/json" https://172.20.0.20/ | jq -r '.[] | {id: .id}' | grep id | cut -d\" -f4`

for event in $events; do
    echo $event
    curl -k -s --header "Authorization: $AUTHKEY" --header "Accept: application/json" --header "Content-Type: application/json" -X "DELETE" https://172.20.0.20/events/$event
done
