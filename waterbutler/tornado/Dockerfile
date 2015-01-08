FROM dockerfile/ubuntu

ENV SOURCE_BRANCH develop
ENV SOURCE_REPO https://github.com/CenterForOpenScience/waterbutler

# Define mount points for OSF Storage
VOLUME ["/data/complete", "/data/pending"]

# Startup script
CMD ["docker-start"]

# Add files.
ADD bin/docker-start /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-start

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
       git \
       libevent-dev \
       libxml2-dev \
       libxslt1-dev \
       zlib1g-dev \
       python3-dev \
       python3-pip \
    && rm -rf /var/lib/apt/lists/*

# uid/gid are configured so subsequent containers can reuse the same account.
RUN groupadd -r docker -g 433 \
    && useradd -u 431 -r -g docker -d /home/docker -s /sbin/nologin -c "Docker user" docker \
    && mkdir /home/docker \
    && chown -R docker:docker /home/docker
ENV HOME /home/docker

# Define working directory.
WORKDIR /app

# Allow docker to access specific folders
RUN mkdir -p /app /env
RUN chown -R docker:docker /app /env

# Install python's virtualenv
RUN pip3 install virtualenv

# Switch to unprivileged docker user
USER docker

# Clone the project's source
RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO .

# Create the virtual environment and install PIP dependancies
RUN virtualenv /env
RUN /env/bin/pip install invoke
RUN /env/bin/pip install -r requirements.txt

USER root
