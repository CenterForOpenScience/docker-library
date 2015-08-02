FROM nginx:1

RUN apt-get update \
    && apt-get install -y \
        inotify-tools \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
