#! /bin/bash

until curl -s -X GET http://172.20.0.52:5601/api/saved_objects/?type=index-pattern; do
    echo "Wait for kibana"
    sleep 10
done

if curl -s -X GET http://172.20.0.52:5601/api/saved_objects/?type=index-pattern; then
    echo  Kibana API up
fi

kibanaout=`curl -s -X GET http://172.20.0.52:5601/api/saved_objects/?type=index-pattern`

while [[ $kibanaout == "Kibana server is not ready yet" ]]; do
    echo "Not yet"
    sleep 10
    kibanaout=`curl -s -X GET http://172.20.0.52:5601/api/saved_objects/?type=index-pattern`
done

curl -X POST http://172.20.0.52:5601/api/saved_objects/index-pattern/elastiflow-* -H "Content-Type: application/json" -H "kbn-xsrf: true" -d @/files/kibana/elastiflow.index_pattern.json

curl -X POST http://172.20.0.52:5601/api/saved_objects/index-pattern/zeek-* -H "Content-Type: application/json" -H "kbn-xsrf: true" -d @/files/zeekpattern.json

curl -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true" "172.20.0.52:5601/api/kibana/settings/defaultIndex" -d "{\"value\":\"zeek-*\"}"

#curl -X POST http://172.20.0.52:5601/api/kibana/dashboards/import -H "Content-Type: application/json" -H "kbn-xsrf: true" -d @/files/pocketsoc_dashboards.json

curl -X PUT "172.20.0.50:9200/_template/zeek" -H 'Content-Type: application/json' -d @/files/mapping.json
