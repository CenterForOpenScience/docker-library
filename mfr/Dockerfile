FROM centerforopenscience/python:3.4-slim

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
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
    # unoconv dependencies
    && apt-get install -y \
        unoconv \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV SOURCE_BRANCH=develop
ENV SOURCE_REPO=https://github.com/CenterForOpenScience/modular-file-renderer.git

# perform an initial build to cache long running compliations
RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
    && pip install -U -r requirements.txt \
    && rm -Rf /code \
    && mkdir /code

# ensure unoconv can locate the uno library
ENV PYTHONPATH=/usr/lib/python3/dist-packages

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/home/python/.cos"]
VOLUME ["/log"]

EXPOSE 7778

CMD ["/bin/bash"]
