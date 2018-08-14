#! /bin/bash

docker exec elasticsearch curl -s -X DELETE "localhost:9200/logstash*"
docker exec elasticsearch curl -s -X DELETE "localhost:9200/elastalert_status*"
docker exec elastalert elastalert-create-index --config /config/config.yaml
