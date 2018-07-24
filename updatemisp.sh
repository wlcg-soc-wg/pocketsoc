#! /bin/bash

TOFIND="RUN sudo -u www-data cp -a \/var\/www\/MISP\/app\/Config\/config.default.php \/var\/www\/MISP\/app\/Config\/config.php"
FILETOMOD="misp-docker/misp-web/Dockerfile"

sed -i.bak "/${TOFIND}/r ./misp-configure.txt"  $FILETOMOD
