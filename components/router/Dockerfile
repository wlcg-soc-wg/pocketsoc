FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof bind-utils dnsmasq vim git libpcap-devel pkgconfig libtool autoconf automake bash make nmap && \
    rpm -Uvh https://github.com/sflow/host-sflow/releases/download/v2.0.18-1/hsflowd-centos7-2.0.18-1.x86_64.rpm

RUN git clone https://github.com/pmacct/pmacct && cd pmacct && ./autogen.sh && ./configure && make && make install

ADD ./files /files

CMD ["/files/startup"]
