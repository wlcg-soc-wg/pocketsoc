FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof bind-utils dnsmasq vim && \
    rpm -Uvh https://github.com/sflow/host-sflow/releases/download/v2.0.18-1/hsflowd-centos7-2.0.18-1.x86_64.rpm

ADD ./files /files

CMD ["/files/startup"]
