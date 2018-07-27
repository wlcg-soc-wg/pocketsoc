FROM centos:7

ADD ./files /files

RUN cp /files/bro.repo /etc/yum.repos.d/bro.repo && cp /files/elastic.repo /etc/yum.repos.d/elastic.repo && yum install -y bro-pf_ring tcpdump net-tools lsof filebeat && cp /files/local.bro /opt/bro/share/bro/site/local.bro && cp /files/filebeat.yml /etc/filebeat/filebeat.yml

CMD ["/files/startup"]
