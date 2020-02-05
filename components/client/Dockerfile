FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof iproute bind-utils vim  git libpcap-devel pkgconfig libtool autoconf automake bash make psmisc && \
    yum update -y

RUN git clone https://github.com/pmacct/pmacct && cd pmacct && ./autogen.sh && ./configure && make && make install

ADD ./files /files

CMD ["/files/startup"]
