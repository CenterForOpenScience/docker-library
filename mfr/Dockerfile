FROM centerforopenscience/python:3.4-slim

# Install dependancies
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
  && rm -rf /var/lib/apt/lists/*

ENV SOURCE_BRANCH=feature/mfr
ENV SOURCE_REPO=https://github.com/icereval/modular-file-renderer.git

# perform an initial build to cache long running compliations
RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
  && pip install -U -r requirements.txt \
  && rm -Rf /code \
  && mkdir /code

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/home/python/.cos"]
VOLUME ["/data/mfrlocalcache"]
VOLUME ["/log"]

EXPOSE 7778

CMD ["/bin/bash"]
