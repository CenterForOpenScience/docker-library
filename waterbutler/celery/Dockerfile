FROM dockerfile/celery

# Startup script
CMD ["docker-start"]

# Add files.
ADD bin/docker-start /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-start
