FROM centos:7

ADD ./files /files

RUN cp /files/bro.repo /etc/yum.repos.d/bro.repo && yum install -y bro-pf_ring tcpdump net-tools lsof && cp /files/local.bro /opt/bro/share/bro/site/local.bro

CMD ["/files/startup"]
