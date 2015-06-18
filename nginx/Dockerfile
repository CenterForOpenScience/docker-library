# Modified to use nginx offical repo

# Credit : Jake Goulding @ https://registry.hub.docker.com/u/shepmaster/nginx-template-image/

FROM nginx:latest

VOLUME ["/var/log/nginx", "/etc/nginx/sites-templates"]
EXPOSE 80 443
WORKDIR /etc/nginx

COPY bin/ /usr/sbin
RUN chmod +x /usr/sbin/render-templates.sh
RUN chmod +x /usr/sbin/substitute-env-vars.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN sed "s/user .*;/user www-data;/" -i /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
