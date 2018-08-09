#! /bin/bash


mkdir -p ./volumes/{misp-web,misp-db}

# MISP

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="misp-docker/misp-web/Dockerfile"
CONFIGFILE="./data/misp-web/misp-configure.txt"

sed -i.bak "/${TOFIND}/r ${CONFIGFILE}"  $FILETOMOD

# elastic

mkdir -p ./{data,volumes}/{elasticsearch,logstash,kibana}/config/
mkdir -p ./volumes/logstash/pipeline/

# Refresh core elastic config from submodule

cp ./docker-elk/elasticsearch/config/elasticsearch.yml ./data/elasticsearch/config/
cp ./docker-elk/logstash/config/logstash.yml ./data/logstash/config/
cp ./docker-elk/kibana/config/kibana.yml ./data/kibana/config/

cp ./data/elasticsearch/config/elasticsearch.yml ./volumes/elasticsearch/config/elasticsearch.yml
cp ./data/logstash/config/logstash.yml ./volumes/logstash/config/logstash.yml
cp ./data/logstash/pipeline/logstash.conf ./volumes/logstash/pipeline/logstash.conf
cp ./data/kibana/config/kibana.yml ./volumes/kibana/config/kibana.yml
