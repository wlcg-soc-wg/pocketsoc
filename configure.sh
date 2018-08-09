#! /bin/bash

# MISP

## Patch misp-web Dockerfile to personalise MISP config

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="misp-docker/misp-web/Dockerfile"
CONFIGFILE="./data/misp-web/misp-configure.txt"

sed -i.bak "/${TOFIND}/r ${CONFIGFILE}"  $FILETOMOD

## Make sure volume directories are in place

mkdir -p ./volumes/{misp-web,misp-db}
 
# Refresh core elastic config from submodule

mkdir -p ./volumes/{elasticsearch,logstash,kibana}/config/

cp ./docker-elk/elasticsearch/config/elasticsearch.yml ./volumes/elasticsearch/config/
cp ./docker-elk/logstash/config/logstash.yml ./volumes/logstash/config/
cp ./docker-elk/kibana/config/kibana.yml ./volumes/kibana/config/
