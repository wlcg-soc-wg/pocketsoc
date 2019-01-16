FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof iproute bind-utils vim && \
    yum update -y

ADD ./files /files

CMD ["/files/startup"]
