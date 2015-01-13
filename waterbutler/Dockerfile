FROM centerforopenscience/python:latest

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    git \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

VOLUME ["/data/osfstorage/pending", "/data/osfstorage/complete"]

# Replace the entrypoint script with our tornado specific script.
COPY docker-entrypoint.sh /

CMD ["/bin/bash"]
