FROM centos:7

RUN yum install -y https://labs.consol.de/repo/stable/rhel7/x86_64/labs-consol-stable.rhel7.noarch.rpm && yum install -y httpd net-tools tcpdump iptables lsof naemon*

ADD ./files /files

EXPOSE 80

CMD ["/files/startup"]
