#! /bin/bash

echo "Prepare log directory..."

mkdir -p ./log

echo "Prepare submodules..."

git submodule update --init

echo "Create networks..."

./tools/build-networks.sh

# MISP

echo "Patch misp-web Dockerfile to personalise MISP config..."

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="repos/misp-docker/misp-web/Dockerfile"
CONFIGFILE="./components/misp-web/misp-configure.txt"

sed -i.bak "/${TOFIND}/r ${CONFIGFILE}"  $FILETOMOD

TOFIND="^RUN pear install Crypt_GPG >>\/tmp\/install.log"
REPLACEWITH="RUN git clone https:\/\/github.com\/pear\/Crypt_GPG.git \&\& cd Crypt_GPG \&\& pear package"

sed -i'' -e "s/${TOFIND}/${REPLACEWITH}/" $FILETOMOD

TOFIND="^RUN pear install Net_GeoIP >>\/tmp\/install.log"
REPLACEWITH="RUN git clone https:\/\/github.com\/pear\/Net_GeoIP.git \&\& cd Net_GeoIP \&\& pear package"

sed -i'' -e "s/${TOFIND}/${REPLACEWITH}/" $FILETOMOD

echo "Patch logstash with Elastiflow config..."

SOURCEDIR="repos/docker-elk/logstash"
DESTDIR="repos/docker-elk/logstash-flow"

cp -r $SOURCEDIR $DESTDIR

FILETOMOD="repos/docker-elk/logstash-flow/Dockerfile"
CONFIGFILE="./components/logstash-flow/logstash-configure.txt"

cat $CONFIGFILE >> $FILETOMOD

echo "Make sure volume directories are in place..."

mkdir -p ./volumes/{misp-web,misp-db}
 
echo "Refresh core elastic config from submodule..."

mkdir -p ./volumes/{elasticsearch,logstash,kibana}/config/

cp ./repos/docker-elk/elasticsearch/config/elasticsearch.yml ./volumes/elasticsearch/config/
cp ./repos/docker-elk/logstash/config/logstash.yml ./volumes/logstash/config/
cp ./repos/docker-elk/kibana/config/kibana.yml ./volumes/kibana/config/

echo "Refresh core elastiflow config from submodule..."

cp -R ./repos/elastiflow/logstash/elastiflow ./volumes/logstash-flow/
