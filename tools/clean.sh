#! /bin/bash

echo "Bringing down docker containers..."
docker-compose down

echo "Removing docker networks..."
docker network rm internal
docker network rm external
docker network rm mirror

echo "Cleaning rules..."
git checkout components/elastalert/config/rules/new_term.yaml

# Clean MISP data

echo "Cleaning MISP data to default..."
rm -rf ./volumes/{misp-web,misp-db}

# Clean ELK data

echo "Cleaning elastic data to default..."
rm -rf ./volumes/{elasticsearch,logstash,kibana}
