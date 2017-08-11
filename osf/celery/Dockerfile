FROM python:2.7

RUN usermod -d /home www-data && chown www-data:www-data /home

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
        # cron (temporary for pre celery-beat jobs)
        cron \
        rsyslog \
        # matplotlib
        libfreetype6-dev \
        libxft-dev \
        # scipy
        gfortran \
        libopenblas-dev \
        liblapack-dev \
        # cryptography
        build-essential \
        libssl-dev \
        libffi-dev \
        python-dev \
        # par2
        par2 \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/cron.daily/* /etc/cron.hourly/* /etc/cron.monthly/* /etc/cron.weekly/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.4
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  	&& gpg --verify /usr/local/bin/gosu.asc \
  	&& rm /usr/local/bin/gosu.asc \
  	&& chmod +x /usr/local/bin/gosu

# https://github.com/nodejs/docker-node/blob/9c25cbe93f9108fd1e506d14228afe4a3d04108f/8.2/Dockerfile
# gpg keys listed at https://github.com/nodejs/node#release-team
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
  ; do \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 8.2.1

RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

ENV SOURCE_BRANCH develop
# ENV SOURCE_BRANCH master
ENV SOURCE_REPO https://github.com/CenterForOpenScience/osf.io.git
ENV WHEELHOUSE /home/.cache/wheelhouse
ENV UPDATE_CMD 'invoke clean && invoke wheelhouse --release && invoke requirements --release'

RUN chmod 600 /etc/crontab

RUN pip install -U pip

RUN pip install \
      invoke==0.13.0 \
      uwsgi==2.0.10

WORKDIR /code

# perform an initial build to cache long running compilations
RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
    && cp website/settings/local-dist.py website/settings/local.py \
    && chown -R www-data:www-data /code

# numpy is a pre-req to scipy
RUN pip wheel numpy==1.8.0 --wheel-dir=/home/.cache/wheelhouse
RUN pip install numpy==1.8.0
RUN invoke wheelhouse --release
RUN invoke requirements --release

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /code
VOLUME /celery

CMD ["invoke", "celery_worker"]
