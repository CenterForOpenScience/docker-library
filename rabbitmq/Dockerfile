FROM rabbitmq:latest

# Temporary fix while waiting for version to bump so PR merge is included.
# https://github.com/docker-library/rabbitmq/commit/a5f531284b81765b5762905909d43c74e5f80795
RUN echo '[{rabbit, [{loopback_users, []}]}].' > /etc/rabbitmq/rabbitmq.config
