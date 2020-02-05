#! /bin/bash

source /config/setauth.sh

curl -s -k --header "Authorization: $AUTHKEY" --header "Accept: application/json" --header "Content-Type: application/json" https://172.20.0.20/ | jq -r '.'
