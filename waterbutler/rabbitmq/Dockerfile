FROM dockerfile/rabbitmq

# Install dependancies
RUN apt-get update \
  	&& rm -rf /var/lib/apt/lists/*

# uid/gid are configured so subsequent containers can reuse the same account.
RUN groupadd -r docker -g 433 \
	&& useradd -u 431 -r -g docker -d /home/docker -s /sbin/nologin -c "Docker user" docker \
	&& mkdir /home/docker \
	&& chown -R docker:docker /home/docker
ENV HOME /home/docker

# Allow docker to access specific folders
RUN mkdir -p /app /env
RUN chown -R docker:docker /app /env

# Switch to unprivileged docker user
USER docker

# Install the OSF Upload Service
RUN git clone https://github.com/CenterForOpenScience/osf-upload-service.git .

# Create the virtual environment and install requirements
RUN virtualenv /env
RUN /env/bin/pip install invoke
RUN /env/bin/pip install -r requirements.txt

# Define mount points
VOLUME ["/data/log"]

# Start the container
CMD ["/env/bin/invoke", "celery"]
