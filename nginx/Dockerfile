# Modified to use nginx offical repo

# Credit : Jake Goulding @ https://registry.hub.docker.com/u/shepmaster/nginx-template-image/

FROM nginx:latest

VOLUME ["/var/log/nginx", "/etc/nginx/sites-templates"]
EXPOSE 80 443
WORKDIR /etc/nginx

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
