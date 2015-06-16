FROM centerforopenscience/python:3.4

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    curl \
    git \
    libev4 \
    libev-dev \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip install uwsgi==2.0.10

# Node : https://registry.hub.docker.com/u/library/node/
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D

ENV NODE_VERSION 0.12.4
ENV NPM_VERSION 2.10.4

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear

RUN npm install -g bower

CMD ["uwsgi", "--ini", "/etc/uwsgi/uwsgi.ini"]
