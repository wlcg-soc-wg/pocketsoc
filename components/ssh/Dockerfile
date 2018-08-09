FROM centos:7

RUN yum install -y net-tools tcpdump iptables lsof iproute bind-utils openssh-server && \
    yum update -y

RUN ssh-keygen -P "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "root:root" | chpasswd

ADD ./files /files

CMD ["/usr/sbin/sshd", "-D"]
