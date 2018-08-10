FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof iproute bind-utils git epel-release gcc python-devel && \
    yum install -y python-pip && \
    pip install "setuptools>=11.3" && \
    git clone https://github.com/Yelp/elastalert.git && cd /elastalert && \
    python setup.py install && \
    pip install "elasticsearch>=5.0.0" && \
    yum update -y

ADD ./config /config

CMD ["/config/startup"]
