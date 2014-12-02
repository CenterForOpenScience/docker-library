FROM dockerfile/ubuntu

# Dependancies
RUN apt-get update \
    && apt-get install -y \
    	git \
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
RUN mkdir -p /app /data/log /data/mnesia
RUN chown -R docker:docker /app /data/log /data/mnesia

# Switch to unprivileged docker
USER docker

# Install the OSF Upload Service
RUN git clone https://github.com/CenterForOpenScience/osf-upload-service.git .

CMD ["/bin/bash"]

# Define mount points.
VOLUME ["/app", "/data/log", "/data/mnesia"]
