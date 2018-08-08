FROM centos:7

ADD ./config /config

RUN cp /config/bro.repo /etc/yum.repos.d/bro.repo && \
    cp /config/elastic.repo /etc/yum.repos.d/elastic.repo && \
    yum install -y bro-pf_ring tcpdump net-tools lsof filebeat cronie vim && \
    yum update -y

CMD ["/config/startup"]
