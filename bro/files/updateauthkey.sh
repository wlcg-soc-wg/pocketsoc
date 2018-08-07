#! /bin/bash

sed -i "s/AUTH_KEY=\"Authorization: XXXXXXXX\"/AUTH_KEY=\"Authorization: $1\"/" /files/simplemisp.sh
