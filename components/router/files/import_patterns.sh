#! /bin/bash

curl -X POST http://172.20.0.52:5601/api/saved_objects/index-pattern/elastiflow-* -H "Content-Type: application/json" -H "kbn-xsrf: true" -d @/files/kibana/elastiflow.index_pattern.json
