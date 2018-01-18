FROM debian:jessie

# Based on: https://hub.docker.com/r/jtgasper3/debian-shibboleth-sp/

ENV APACHE2_VERSION 2.4.10-10+deb8u11
ENV SHIBBOLETH_SP_VERSION 2.5.3+dfsg-2+deb8u1
RUN apt-get update \
    && apt-get install -y \
      apache2=$APACHE2_VERSION \
      libapache2-mod-shib2=$SHIBBOLETH_SP_VERSION \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN rm /etc/apache2/sites-enabled/*

ADD ./shibboleth /etc/shibboleth
ADD ./apache2 /etc/apache2

RUN a2enmod headers \
    && a2enmod env \
    && a2enmod proxy_http \
    && a2enmod ssl \
    && a2enmod rewrite \
    && sed -ri 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g;' /etc/apache2/apache2.conf \
    && sed -ri 's!^(\s*CustomLog)\s+\S+\s+(.*$)!\1 /proc/self/fd/1 \2 env=\!dontlog!g;' /etc/apache2/conf-available/other-vhosts-access-log.conf \
    && echo "ServerSignature Off" >> /etc/apache2/apache2.conf \
    && echo "ServerTokens Prod" >> /etc/apache2/apache2.conf

EXPOSE 8080
EXPOSE 8443

COPY httpd-foreground /usr/local/bin/
RUN chmod +x /usr/local/bin/httpd-foreground

CMD ["httpd-foreground"]
