#! /bin/bash

# MISP

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="misp-docker/misp-web/Dockerfile"
CONFIGFILE="./data/misp-configure.txt"

sed -i.bak "/${TOFIND}/r ${CONFIGFILE}"  $FILETOMOD

# Logstash

cp ./data/logstash.conf ./docker-elk/logstash/pipeline
