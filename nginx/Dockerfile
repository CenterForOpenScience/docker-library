FROM debian:jessie

RUN apt-get update \
    && apt-get install -y \
        inotify-tools \
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
				libcurl4-openssl-dev \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Modsecurity
RUN cd /usr/src/ && git clone https://github.com/SpiderLabs/ModSecurity.git /usr/src/modsecurity
RUN	cd /usr/src/modsecurity && \
		./autogen.sh && \
		./configure --enable-standalone-module --disable-mlogc && \
		make

# Nginx
RUN	cd / && wget http://nginx.org/download/nginx-1.10.2.tar.gz && \
		tar xvzf nginx-1.10.2.tar.gz && \
		cd ../nginx-1.10.2 && ./configure --user=root --group=root --with-debug --with-ipv6 --with-http_ssl_module --add-module=/usr/src/modsecurity/nginx/modsecurity --with-http_ssl_module --without-http_access_module --without-http_auth_basic_module --without-http_autoindex_module --without-http_empty_gif_module --without-http_fastcgi_module --without-http_referer_module --without-http_memcached_module --without-http_scgi_module --without-http_split_clients_module --without-http_ssi_module --without-http_uwsgi_module && \
		make && \
		make install

# Configure Env
RUN	ln -s /usr/local/nginx/sbin/nginx /bin/nginx && \
		cp /usr/src/modsecurity/unicode.mapping /usr/local/nginx/conf/ && \
		mkdir -p /opt/modsecurity/var/audit/

# Install Signature
RUN git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/src/owasp-modsecurity-crs
RUN	cp -R /usr/src/owasp-modsecurity-crs/rules/ /usr/local/nginx/conf/
#RUN	mv /usr/local/nginx/conf/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf{.example,}
#RUN	mv /usr/local/nginx/conf/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf{.example,}

# Cleanup
RUN apt-get purge -y build-essential wget git && \
		rm /nginx-1.10.2.tar.gz

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
