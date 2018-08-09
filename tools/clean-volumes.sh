#! /bin/bash

# Clean MISP data

rm -rf ./volumes/{misp-web,misp-db}

# Clean ELK data

rm -rf ./volumes/{elasticsearch,logstash,kibana}
