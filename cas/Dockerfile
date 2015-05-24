FROM java:8-jdk

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r cas && useradd -r -g cas cas -d /home/cas -m

RUN apt-get update \
    && apt-get install -y \
      git \
      maven \
    && apt-get clean

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
	&& curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& apt-get purge -y --auto-remove curl

ENV SOURCE_BRANCH=master
ENV SOURCE_REPO=https://github.com/CenterForOpenScience/cas-overlay.git

WORKDIR /cas-overlay

RUN chown -R cas /cas-overlay

# perform an initial build to cache maven dependencies
USER cas

RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
  && mvn clean install

USER root

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/etc/cas", "/home/cas/.cos", "/log"]

EXPOSE 8080 8443

# ENV MAVEN_OPTS=# "-Xms256m -Xmx512m"
CMD ["/usr/bin/mvn", "-pl", "cas-server-webapp/", "jetty:run"]
