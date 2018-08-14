#! /bin/bash

CURLFILE=/config/pull_misp.sh

AUTHKEY=`docker exec bro bash -c "grep Authorization ${CURLFILE} | awk '{print \\$NF}' | sed 's/\"//'  "`

docker exec bro bash -c "sed -i \"s/${AUTHKEY}/XXXXXXXX/\" ${CURLFILE}"
