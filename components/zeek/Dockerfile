FROM centos:7

ADD ./config /config

RUN cp /config/zeek.repo /etc/yum.repos.d/zeek.repo && \
    cp /config/elastic.repo /etc/yum.repos.d/elastic.repo && \
    yum install -y bro-pf_ring tcpdump net-tools lsof filebeat cronie vim epel-release && \
    yum install -y tcpreplay jq python-requests python-pip memcached && \
    yum update -y && \
    pip install pymemcache

CMD ["/config/startup"]
