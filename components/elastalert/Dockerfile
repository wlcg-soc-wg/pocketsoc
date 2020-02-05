FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof iproute bind-utils git epel-release gcc python3 python3-devel nmap-ncat && \
    yum install -y python3-pip && \
    #pip install wheel && \
    pip3 install "setuptools>=11.3" && \
    git clone https://github.com/Yelp/elastalert.git && cd /elastalert && \
    python3 setup.py install && \
    pip3 install "elasticsearch>=5.0.0" && \
    yum update -y

ADD ./config /config

CMD ["/config/startup"]
