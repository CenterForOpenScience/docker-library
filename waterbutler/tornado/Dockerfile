FROM ../python:3.4

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r python && useradd -r -g python python

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

RUN mkdir -p /code && chown -R python:python /code

WORKDIR /code

RUN su python -c "git clone -b $SOURCE_BRANCH $SOURCE_REPO ."
RUN pip install -r requirements.txt

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["python-app"]
