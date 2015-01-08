FROM dockerfile/rabbitmq

# Define mount points.
# VOLUME ["/data/log", "/data/mnesia"]

# Define default command.
# CMD ["rabbitmq-start"]

# # Expose ports.
# EXPOSE 5672
# EXPOSE 15672

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
       git \
    && rm -rf /var/lib/apt/lists/*

# Switch to unprivileged docker user
USER rabbitmq

