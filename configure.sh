#! /bin/bash

prefix=$1

echo "Prepare log directory..."

mkdir -p $prefix/log

echo "Prepare submodules..."

cd $prefix

git submodule update --init

echo "Create networks..."

$prefix/tools/build-networks.sh

# MISP

echo "Patch misp-web Dockerfile to personalise MISP config..."

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="repos/misp-docker/misp-web/Dockerfile"
CONFIGFILE="$prefix/components/misp-web/misp-configure.txt"

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
CONFIGFILE="$prefix/components/logstash-flow/logstash-configure.txt"

cat $CONFIGFILE >> $FILETOMOD

echo "Make sure volume directories are in place..."

mkdir -p $prefix/volumes/{misp-web,misp-db}
 
echo "Refresh core elastic config from submodule..."

mkdir -p $prefix/volumes/{elasticsearch,logstash,kibana}/config/

cp $prefix/repos/docker-elk/elasticsearch/config/elasticsearch.yml $prefix/volumes/elasticsearch/config/
cp $prefix/repos/docker-elk/logstash/config/logstash.yml $prefix/volumes/logstash/config/
cp $prefix/repos/docker-elk/kibana/config/kibana.yml $prefix/volumes/kibana/config/

echo "Refresh core elastiflow config from submodule..."

cp -R $prefix/repos/elastiflow/logstash/elastiflow $prefix/volumes/logstash-flow/
