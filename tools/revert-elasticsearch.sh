#! /bin/bash

elastic_state=`docker inspect -f {{.State.Running}} elasticsearch`

while [[ $elastic_state == "false" ]]; do
    echo "Waiting for elasticsearch"
    sleep 10
    elastic_state=`docker inspect -f {{.State.Running}} elasticsearch`
done

echo "Elasticsearch up"

indices=`docker exec elasticsearch curl -s -X GET "localhost:9200/_cat/indices?v" | grep -v health | awk '{print $3}' | cut -d- -f1`

for index in $indices; do
    echo $index
    docker exec elasticsearch curl -s -X DELETE "localhost:9200/$index*"
    echo
done

remaining=`docker exec elasticsearch curl -s -X GET "localhost:9200/_cat/indices?v" | grep -v health | awk '{print $3}' | wc -l`

echo "Indices remaining = "$remaining
