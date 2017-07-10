FROM debian:stretch-slim

ENV NGINX_VERSION 1.13.1

RUN apt-get update \
    && apt-get install -y \
    	inotify-tools \
      g++ \
      flex \
      bison \
      curl \
      doxygen \
      libyajl-dev \
      libgeoip-dev \
      dh-autoreconf \
      libcurl4-gnutls-dev \
      git \
      wget \
      build-essential \
      libpcre3 \
      libpcre3-dev \
      libssl-dev \
      libtool \
      autoconf \
      apache2-dev \
      libxml2-dev \
      zlib1g-dev \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Create log and cache directories
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/cache/nginx

# Modsecurity
RUN cd /usr/src/ && git clone https://github.com/SpiderLabs/ModSecurity.git
RUN cd /usr/src/ModSecurity && \
    git checkout -b v3/master origin/v3/master && \
    sh build.sh && \
    git submodule init && \
    git submodule update && \
    ./configure && \
    make && \
    make install

RUN cd /usr/src/ && git clone https://github.com/SpiderLabs/ModSecurity-nginx.git /usr/src/modsecurity-nginx

# Nginx
RUN cd / && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
	tar xvzf nginx-${NGINX_VERSION}.tar.gz && \
	cd ../nginx-${NGINX_VERSION} && ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --add-module=/usr/src/modsecurity-nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' && \
	make && \
	make install

# Install Signature
RUN git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/src/owasp-modsecurity-crs
RUN cp -R /usr/src/owasp-modsecurity-crs/rules/ /etc/nginx/
RUN mv /etc/nginx/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example /etc/nginx/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf
RUN mv /etc/nginx/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf.example /etc/nginx/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf

# Cleanup
RUN apt-get purge -y build-essential wget git && \
	rm /nginx-${NGINX_VERSION}.tar.gz

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
