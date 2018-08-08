#! /bin/bash

CURLFILE=/config/pull_misp.sh

docker exec bro bash -c "sed -i \"s/XXXXXXXX/$1/\" ${CURLFILE}"
