FROM centos:7

RUN yum install -y httpd net-tools tcpdump iptables lsof vim

ADD ./files /files

EXPOSE 80

CMD ["/files/startup"]
