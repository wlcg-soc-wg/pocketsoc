#! /bin/bash

CURLFILE=/config/pull_misp.sh

sed -i "s/AUTH_KEY=\"Authorization: XXXXXXXX\"/AUTH_KEY=\"Authorization: $1\"/" ${CURLFILE}
