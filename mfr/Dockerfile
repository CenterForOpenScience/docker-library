FROM centerforopenscience/python:3.4-slim

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    git \
    par2 \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/data/mfrlocalcache"]
VOLUME ["/log"]

EXPOSE 7777

CMD ["/bin/bash"]
