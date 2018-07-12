FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof iproute

ADD ./files /files

CMD ["/files/startup"]
