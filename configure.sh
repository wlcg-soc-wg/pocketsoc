#! /bin/bash

# MISP

## Patch misp-web Dockerfile to personalise MISP config

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="external/misp-docker/misp-web/Dockerfile"
CONFIGFILE="./components/misp-web/misp-configure.txt"

sed -i.bak "/${TOFIND}/r ${CONFIGFILE}"  $FILETOMOD

## Make sure volume directories are in place

mkdir -p ./external/volumes/{misp-web,misp-db}
 
# Refresh core elastic config from submodule

mkdir -p ./external/volumes/{elasticsearch,logstash,kibana}/config/

cp ./external/docker-elk/elasticsearch/config/elasticsearch.yml ./external/volumes/elasticsearch/config/
cp ./external/docker-elk/logstash/config/logstash.yml ./external/volumes/logstash/config/
cp ./external/docker-elk/kibana/config/kibana.yml ./external/volumes/kibana/config/
