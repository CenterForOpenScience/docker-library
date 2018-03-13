FROM centos:centos7

# Based on: https://github.com/jtgasper3/docker-images/blob/master/centos-shib-sp/Dockerfile

ENV APACHE_VERSION 2.4.6-67.el7.centos.6
ENV SHIBBOLETH_VERSION 2.6.1-3.1
RUN yum -y update \
    && yum -y install wget \
    && wget http://download.opensuse.org/repositories/security://shibboleth/CentOS_7/security:shibboleth.repo -P /etc/yum.repos.d \
    && sed -i -e "s/download\./\downloadcontent\./" /etc/yum.repos.d/security\:shibboleth.repo \
    && yum -y install httpd-${APACHE_VERSION} mod_ssl shibboleth-${SHIBBOLETH_VERSION} \
    && yum -y clean all

RUN echo "export LD_LIBRARY_PATH=/opt/shibboleth/lib64:$LD_LIBRARY_PATH" >> /etc/sysconfig/shibd \
    && echo "export SHIBD_USER=shibd" >> /etc/sysconfig/shibd \
    && sed -i \
        -e "s|log4j.appender.shibd_log=.*$|log4j.appender.shibd_log=org.apache.log4j.ConsoleAppender|" \
        -e "s|log4j.appender.warn_log=.*$|log4j.appender.warn_log=org.apache.log4j.ConsoleAppender|" \
        -e "s|log4j.appender.tran_log=.*$|log4j.appender.tran_log=org.apache.log4j.ConsoleAppender|" \
        -e "s|log4j.appender.sig_log=.*$|log4j.appender.sig_log=org.apache.log4j.ConsoleAppender|" \
        /etc/shibboleth/shibd.logger

RUN sed -i -r \
        -e "s|^(\s*ErrorLog)\s+\S+|\1 /dev/stderr|" \
        -e 's|^(\s*CustomLog)\s+\S+\s+(.*$)|\1 /dev/stdout \2 env=\!dontlog|' \
        /etc/httpd/conf/httpd.conf \
    && echo "ServerSignature Off" >> /etc/httpd/conf/httpd.conf \
    && echo "ServerTokens Prod" >> /etc/httpd/conf/httpd.conf \
    && rm -f /etc/httpd/conf.d/{autoindex.conf,welcome.conf}

COPY httpd-shibd-foreground /usr/local/bin/
RUN chmod +x /usr/local/bin/httpd-shibd-foreground

EXPOSE 80 443

CMD ["httpd-shibd-foreground"]
