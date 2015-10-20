FROM python:3.5

RUN usermod -d /home www-data && chown www-data:www-data /home

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
        git \
        libev4 \
        libev-dev \
        libevent-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
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

ENV SOURCE_BRANCH=master
ENV SOURCE_REPO=https://github.com/CenterForOpenScience/scrapi.git
ENV WHEELHOUSE /home/.cache/wheelhouse
ENV UPDATE_CMD 'invoke wheelhouse && invoke requirements'

RUN pip install -U \
      invoke \
      wheel \
      uwsgi==2.0.10

WORKDIR /code

# perform an initial build to cache long running compilations
RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
    && chown -R www-data:www-data /code

RUN invoke wheelhouse
RUN invoke requirements

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /code

CMD ["/bin/bash"]
