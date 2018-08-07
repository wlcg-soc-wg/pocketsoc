FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof iproute bind-utils

ADD ./files /files

CMD ["/files/startup"]
