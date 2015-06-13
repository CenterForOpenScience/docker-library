FROM centerforopenscience/python:3.4-slim

# mfr dependencies
RUN apt-get update \
    && apt-get install -y \
        git \
        make \
        gcc \
        build-essential \
        gfortran \
        libblas-dev \
        libevent-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists

# unoconv dependencies
RUN apt-get update \
    && apt-get install -y \
        unoconv \
        imagemagick \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists

# unoconv additional fonts
RUN apt-get update \
    && apt-get install -y \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get install -y \
        fonts-arphic-ukai \
        fonts-arphic-uming \
        fonts-ipafont-mincho \
        fonts-ipafont-gothic \
        fonts-unfonts-core \
        ttf-wqy-zenhei \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists

ENV SOURCE_BRANCH=develop
ENV SOURCE_REPO=https://github.com/CenterForOpenScience/modular-file-renderer.git

# perform an initial build to cache long running compliations
RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
    && pip install -U -r requirements.txt \
    && rm -Rf /code \
    && mkdir /code

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/home/python/.cos"]
VOLUME ["/log"]

EXPOSE 7778

CMD ["/usr/bin/supervisord"]
