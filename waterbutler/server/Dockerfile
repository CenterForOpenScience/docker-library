FROM icereval/python:latest

# Workaround for VirtualBox disk mounting issue.
# https://github.com/boot2docker/boot2docker/issues/581#issuecomment-68227494
RUN usermod -u 1000 python

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

RUN git clone -b develop https://github.com/CenterForOpenScience/waterbutler .
RUN pip install -r requirements.txt
RUN chown -R python /code

# Replace the entrypoint script with our tornado specific script.
COPY docker-entrypoint.sh /

CMD ["/bin/bash"]
