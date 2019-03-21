FROM java:8-jdk

RUN apt-get update \
    && apt-get install -y \
      git \
      maven \
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

RUN usermod -d /home www-data \
    && chown www-data:www-data /home

ENV SOURCE_BRANCH=master
ENV SOURCE_REPO=https://github.com/CenterForOpenScience/cas-overlay.git

# perform an initial build to cache maven dependencies
RUN mkdir /cas-overlay \
    && chown www-data /cas-overlay \
    && cd /cas-overlay \
    && gosu www-data git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
    && gosu www-data mvn clean install \
    && rm -Rf /cas-overlay

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /cas-overlay

VOLUME /etc/cas
VOLUME /home/.cos

EXPOSE 8080
EXPOSE 8443

# ENV MAVEN_OPTS=# "-Xms256m -Xmx512m"
CMD ["/usr/bin/mvn", "-pl", "cas-server-webapp/", "jetty:run"]
