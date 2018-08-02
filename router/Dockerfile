FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof bind-utils dnsmasq vim

ADD ./files /files

CMD ["/files/startup"]
