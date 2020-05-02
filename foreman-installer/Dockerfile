FROM centos:7

ARG foreman_version="2.0"

LABEL maintainer="lukas.steiner@steinheilig.de"
LABEL foreman_version=${foreman_version}

RUN yum -y install https://yum.puppet.com/puppet6-release-el-7.noarch.rpm \
    http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    https://yum.theforeman.org/releases/${foreman_version}/el7/x86_64/foreman-release.rpm \
    && yum -y install foreman-release-scl \
    && yum -y install foreman-installer \
    && groupadd -g 1000 puppet

COPY ssl/ca.pem /etc/ssl/certs/foreman-ca.pem
COPY ssl/server.pem /etc/ssl/certs/foreman.pem
COPY ssl/server-key.pem /etc/ssl/private_keys/foreman.pem

CMD ["/sbin/init"]
