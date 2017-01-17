FROM ubuntu:trusty

RUN apt-get update \
    && apt-get install -y \
        numactl \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.4
RUN apt-get update \
    && apt-get install -y \
        curl \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  	&& gpg --verify /usr/local/bin/gosu.asc \
  	&& rm /usr/local/bin/gosu.asc \
  	&& chmod +x /usr/local/bin/gosu \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

#ENV FWKNOP_VERSION 2.0.0rc2-2+deb7u2
#=$FWKNOP_VERSION

RUN apt-get update \
    && apt-get install vim -y \
    && apt-get install -y ca-certificates wget -y \
    && apt-get install build-essential -y


RUN  apt-get install libpcap-dev -y \
     && apt-get install iptables -y

#RUN apt-get install fwknop-server -y

RUN wget https://www.cipherdyne.org/signing_key
RUN gpg --import signing_key

RUN wget http://www.cipherdyne.org/fwknop/download/fwknop-2.6.3.tar.gz \
    && wget http://www.cipherdyne.org/fwknop/download/fwknop-2.6.3.tar.gz.asc \
    && gpg --verify fwknop-2.6.3.tar.gz.asc

RUN tar xfz fwknop-2.6.3.tar.gz \
    && cd fwknop-2.6.3 \
    && ./configure --prefix=/usr --sysconfdir=/etc \
    && make \
    && make install

RUN mv /etc/fwknop/fwknopd.conf /etc/fwknop/fwknopd.orig \
      && mv /etc/fwknop/access.conf /etc/fwknop/access.orig

#    && apt-get install fwknop-client -y \
#    && apt-get install git -y \
#    && git clone https://github.com/mrash/fwknop.git \
#    && cp fwknop/extras/upstart/fwknop.conf /etc/init

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/fwknopd", "-f"]
#CMD ["tail", "-f", "/var/log/dpkg.log"]