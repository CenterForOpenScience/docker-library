# Credit : Jake Goulding @ https://registry.hub.docker.com/u/shepmaster/nginx-template-image/

FROM nginx:1

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-c", "/etc/nginx/nginx.conf.tmp", "-g", "daemon off;"]
