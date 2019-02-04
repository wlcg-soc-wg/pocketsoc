#! /bin/bash

# Prep log dir

mkdir -p ./log

# Prep submodules

git submodule update --init

# Create networks

./tools/build-networks.sh

# MISP

## Patch misp-web Dockerfile to personalise MISP config

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="external/misp-docker/misp-web/Dockerfile"
CONFIGFILE="./components/misp-web/misp-configure.txt"

sed -i.bak "/${TOFIND}/r ${CONFIGFILE}"  $FILETOMOD

TOFIND="^RUN pear install Crypt_GPG >>\/tmp\/install.log"
REPLACEWITH="RUN git clone https:\/\/github.com\/pear\/Crypt_GPG.git \&\& cd Crypt_GPG \&\& pear package"

sed -i'' -e "s/${TOFIND}/${REPLACEWITH}/" $FILETOMOD

TOFIND="^RUN pear install Net_GeoIP >>\/tmp\/install.log"
REPLACEWITH="RUN git clone https:\/\/github.com\/pear\/Net_GeoIP.git \&\& cd Net_GeoIP \&\& pear package"

sed -i'' -e "s/${TOFIND}/${REPLACEWITH}/" $FILETOMOD

## Patch logstash with Elastiflow config

SOURCEDIR="external/docker-elk/logstash"
DESTDIR="external/docker-elk/logstash-flow"

cp -r $SOURCEDIR $DESTDIR

FILETOMOD="external/docker-elk/logstash-flow/Dockerfile"
CONFIGFILE="./components/logstash-flow/logstash-configure.txt"

cat $CONFIGFILE >> $FILETOMOD

## Make sure volume directories are in place

mkdir -p ./external/volumes/{misp-web,misp-db}
 
# Refresh core elastic config from submodule

mkdir -p ./external/volumes/{elasticsearch,logstash,kibana}/config/

cp ./external/docker-elk/elasticsearch/config/elasticsearch.yml ./external/volumes/elasticsearch/config/
cp ./external/docker-elk/logstash/config/logstash.yml ./external/volumes/logstash/config/
cp ./external/docker-elk/kibana/config/kibana.yml ./external/volumes/kibana/config/

# Refresh core elastiflow config from submodule

cp -R ./external/elastiflow/logstash/elastiflow ./external/volumes/logstash-flow/
