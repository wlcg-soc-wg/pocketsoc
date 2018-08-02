FROM httpd:2.4
COPY ./demonstrator/ /usr/local/apache2/htdocs/

RUN hashstring=`date``hostname` && echo $hashstring > /usr/local/apache2/htdocs/hash.html
