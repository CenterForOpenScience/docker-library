FROM python:latest

ENV SOURCE_BRANCH develop
ENV SOURCE_REPO https://github.com/CenterForOpenScience/waterbutler

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r tornado && useradd -r -g tornado tornado

# Workaround for VirtualBox disk mounting issue.
# https://github.com/boot2docker/boot2docker/issues/581#issuecomment-68227494
RUN usermod -u 1000 tornado

# Install dependancies
RUN apt-get update \
  && apt-get install -y \
    git \
    libevent-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

# Allow access specific folders
RUN mkdir -p /app /env
RUN chown -R tornado:tornado /app /env

# Define working directory.
WORKDIR /app

# Clone the project's source
RUN su tornado -c "git clone -b $SOURCE_BRANCH $SOURCE_REPO ."

# Create the virtual environment and install PIP dependancies
RUN pip install invoke
RUN pip install -r requirements.txt

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["tornado-server"]
