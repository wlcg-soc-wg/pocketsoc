#! /bin/bash


mkdir -p ./volumes/{misp-web,misp-db}

# MISP

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="misp-docker/misp-web/Dockerfile"
CONFIGFILE="./data/misp-web/misp-configure.txt"

sed -i.bak "/${TOFIND}/r ${CONFIGFILE}"  $FILETOMOD

mkdir -p ./data/{elasticsearch,logstash,kibana}/config/

# elastic

# Refresh core elastic config from submodule

cp ./docker-elk/elasticsearch/config/elasticsearch.yml ./data/elasticsearch/config/
cp ./docker-elk/logstash/config/logstash.yml ./data/logstash/config/
cp ./docker-elk/kibana/config/kibana.yml ./data/kibana/config/

cp -R ./data/elasticsearch ./volumes/
cp -R ./data/logstash ./volumes/
cp -R ./data/kibana ./volumes/
