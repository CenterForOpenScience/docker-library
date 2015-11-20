FROM java:8-jdk

RUN apt-get update \
    && apt-get install -y \
      vim \
      supervisor \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV SHIBBOLETH_SP_VERSION 2.5.3+dfsg-2
RUN apt-get update \
    && apt-get install -y \
      libxerces-c3.1 \
      libxml-security-c17 \
      libxmltooling6 \
      opensaml2-schemas \
      xmltooling-schemas \
      libshibsp6 \
      libshibsp-plugins \
      shibboleth-sp2-common=$SHIBBOLETH_SP_VERSION \
      shibboleth-sp2-utils=$SHIBBOLETH_SP_VERSION \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY supervisor/conf.d/shibboleth.conf /etc/supervisor/conf.d/shibboleth.conf

RUN mkdir -p /var/run/shibboleth /var/log/shibboleth
# RUN ln -sf /dev/stdout /var/log/shibboleth/shibd.log
RUN chown -R _shibd /var/run/shibboleth /var/log/shibboleth
# RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN shib-keygen -f


VOLUME /etc/shibboleth

EXPOSE 9001
EXPOSE 9002

CMD ["/usr/bin/supervisord"]
