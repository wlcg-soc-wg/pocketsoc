#! /bin/bash


mkdir -p ./volumes/{misp-web,misp-db}

# MISP

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="misp-docker/misp-web/Dockerfile"
CONFIGFILE="./data/misp-web/misp-configure.txt"

sed -i.bak "/${TOFIND}/r ${CONFIGFILE}"  $FILETOMOD

# elastic

mkdir -p ./volumes/{elasticsearch,logstash,kibana}/config/

# Refresh core elastic config from submodule

cp ./docker-elk/elasticsearch/config/elasticsearch.yml ./volumes/elasticsearch/config/
cp ./docker-elk/logstash/config/logstash.yml ./volumes/logstash/config/
cp ./docker-elk/kibana/config/kibana.yml ./volumes/kibana/config/
