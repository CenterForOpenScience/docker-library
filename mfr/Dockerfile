FROM python:3.4-slim

RUN apt-get update \
    # mfr dependencies
    && apt-get install -y \
        git \
        make \
        gcc \
        build-essential \
        gfortran \
        libblas-dev \
        libevent-dev \
        libfreetype6-dev \
        libjpeg-dev \
        libpng12-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
    # unoconv dependencies
    && apt-get install -y \
        unoconv \
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

ENV SOURCE_BRANCH=develop
ENV SOURCE_REPO=https://github.com/CenterForOpenScience/modular-file-renderer.git

# perform an initial build to cache long running compliations
RUN mkdir /code \
    && cd /code \
    && git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
    && pip install -U -r requirements.txt \
    && rm -Rf /code

# ensure unoconv can locate the uno library
ENV PYTHONPATH=/usr/lib/python3/dist-packages

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /code

VOLUME /home/.cos
VOLUME /unoconv

EXPOSE 7778

CMD ["invoke", "server"]
