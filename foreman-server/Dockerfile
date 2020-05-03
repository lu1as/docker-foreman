FROM centos:7

ARG foreman_version="2.0"

LABEL maintainer="lukas.steiner@steinheilig.de"
LABEL foreman_version=${foreman_version}

RUN yum -y install https://yum.puppet.com/puppet6-release-el-7.noarch.rpm \
    http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    https://yum.theforeman.org/releases/${foreman_version}/el7/x86_64/foreman-release.rpm \
    && yum -y install foreman-release-scl \
    && yum install -y foreman foreman-service foreman-libvirt foreman-cli foreman-console foreman-postgresql

COPY entrypoint.sh /entrypoint.sh
COPY --chown=foreman:foreman config/* /etc/foreman/

RUN chown foreman /etc/foreman /usr/share/foreman/config/initializers/local_secret_token.rb \
    && chmod 600 /etc/foreman/encryption_key.rb /etc/foreman/database.yml \
    && yum install -y sudo \
    && echo "foreman ALL=NOPASSWD:/bin/update-ca-trust,/bin/yum" >> /etc/sudoers

USER foreman
WORKDIR /usr/share/foreman

CMD ["/entrypoint.sh"]

RUN sudo yum install -y tfm-rubygem-foreman_templates tfm-rubygem-foreman_dhcp_browser
