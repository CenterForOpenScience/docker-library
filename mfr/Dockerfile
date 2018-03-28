FROM python:3.5-slim

RUN usermod -d /home www-data && chown www-data:www-data /home

RUN apt-get update \
    # mfr dependencies
    && apt-get install -y \
        git \
        make \
        gcc \
        build-essential \
        gfortran \
        r-base \
        libblas-dev \
        libevent-dev \
        libfreetype6-dev \
        libjpeg-dev \
        libpng12-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        # extended tiff support
        libtiff5-dev \
        # convert .step to jsc3d-compatible format
        freecad \
    # pspp dependencies
    && apt-get install -y \
        pspp \
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

ENV LIBREOFFICE_VERSION 6.0.2.1
ENV LIBREOFFICE_ARCHIVE LibreOffice_6.0.2.1_Linux_x86-64_deb.tar.gz
ENV LIBREOFFICE_MIRROR_URL https://downloadarchive.documentfoundation.org/libreoffice/old/
RUN apt-get update \
    && apt-get install -y \
        curl \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys AFEEAEA3 \
    && curl -SL "$LIBREOFFICE_MIRROR_URL/$LIBREOFFICE_VERSION/deb/x86_64/$LIBREOFFICE_ARCHIVE" -o $LIBREOFFICE_ARCHIVE \
    && curl -SL "$LIBREOFFICE_MIRROR_URL/$LIBREOFFICE_VERSION/deb/x86_64/$LIBREOFFICE_ARCHIVE.asc" -o $LIBREOFFICE_ARCHIVE.asc \
    && gpg --verify "$LIBREOFFICE_ARCHIVE.asc" \
    && mkdir /tmp/libreoffice \
    && tar -xvf "$LIBREOFFICE_ARCHIVE" -C /tmp/libreoffice/ --strip-components=1 \
    && dpkg -i /tmp/libreoffice/**/*.deb \
    && rm $LIBREOFFICE_ARCHIVE* \
    && rm -Rf /tmp/libreoffice \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install unoconv==0.8.2

ENV SOURCE_BRANCH master
ENV SOURCE_REPO https://github.com/CenterForOpenScience/modular-file-renderer.git
ENV WHEELHOUSE /home/.cache/wheelhouse
ENV UPDATE_CMD 'invoke wheelhouse && invoke install'
# ensure unoconv can locate the uno library
ENV PYTHONPATH=/usr/lib/python3/dist-packages

RUN pip install -U wheel
RUN pip install invoke==0.13.0 \
    setuptools==30.4.0

WORKDIR /code

# perform an initial build to cache long running compilations
RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
    && chown -R www-data:www-data /code

RUN invoke wheelhouse
RUN invoke install

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 7778
VOLUME /code

CMD ["invoke", "server"]
