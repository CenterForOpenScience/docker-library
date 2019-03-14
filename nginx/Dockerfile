FROM debian:stretch-slim

ENV \
    # http://nginx.org/en/CHANGES
    NGINX_VERSION=1.15.9 \
    # LUAJIT_VERSION=v2.0.5 \
    # LUA_NGINX_MODULE_VERSION=v0.10.11 \
    # https://github.com/openresty/echo-nginx-module/releases
    ECHO_NGINX_MODULE_VERSION=v0.61 \
    MODSECURITY_VERSION=v3.0.0-rc1 \
    MODSECURITY_NGINX_VERSION=master \
    MODSECURITY_NGINX_COMMIT=a2a5858d249222938c2f5e48087a922c63d7f9d8 \
    # http://hg.nginx.org/njs/tags
    NGINSCRIPT_VERSION=0.2.8 \
    NGX_BROTLI_VERSION=master \
    NGX_DEVEL_KIT_VERSION=v0.3.0 \
    NGX_HTTP_REDIS=0.3.8 \
    NGINX_MODULE_VTS_VERSION=v0.1.18 \
    REDIS2_NGINX_MODULE_VERSION=v0.14 \
    SET_MISC_NGINX_MODULE_VERSION=v0.31 \
    SRCACHE_NGINX_MODULE_VERSION=v0.31 \
    NGINX_GPGKEY=573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62

RUN adduser --system --disabled-password --home /var/cache/nginx --shell /sbin/nologin --group nginx \
    && apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y gnupg1 apt-transport-https ca-certificates \
    && \
	found=''; \
	for server in \
		ha.pool.sks-keyservers.net \
		hkp://keyserver.ubuntu.com:80 \
		hkp://p80.pool.sks-keyservers.net:80 \
		pgp.mit.edu \
	; do \
		echo "Fetching GPG key $NGINX_GPGKEY from $server"; \
		apt-key adv --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$NGINX_GPGKEY" && found=yes && break; \
	done; \
    test -z "$found" && echo >&2 "error: failed to fetch GPG key $NGINX_GPGKEY" && exit 1; \
	apt-get remove --purge --auto-remove -y gnupg1 && rm -rf /var/lib/apt/lists/* \
    && echo "deb https://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list.d/nginx.list \
    && echo "deb-src https://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list.d/nginx.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        inotify-tools \
        curl \
        libyajl-dev \
        libgeoip1 \
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
        libxml2-dev \
        zlib1g-dev \
        libperl-dev \
    && cd /usr/src \
    # Create log and cache directories
    && mkdir -p \
        /etc/nginx \
        /var/log/nginx \
        /var/cache/nginx \
    && git clone https://github.com/SpiderLabs/ModSecurity.git --branch ${MODSECURITY_VERSION} --single-branch \
    && cd ModSecurity \
    && sh build.sh \
    && git submodule update --init \
    && ./configure --disable-doxygen-doc --disable-examples --disable-dependency-tracking \
    && make \
    && make install \
    && cd .. \
    && git clone https://github.com/SpiderLabs/ModSecurity-nginx.git --branch ${MODSECURITY_NGINX_VERSION} --single-branch \
    && cd ModSecurity-nginx \
    && git checkout ${MODSECURITY_NGINX_COMMIT} \
    && cd .. \
    && git clone https://github.com/nginx/njs.git --branch ${NGINSCRIPT_VERSION} --single-branch \
    && git clone https://github.com/google/ngx_brotli.git --branch ${NGX_BROTLI_VERSION} --single-branch \
    && cd ngx_brotli \
    && git submodule update --init \
    && cd .. \
    && git clone https://github.com/openresty/srcache-nginx-module.git --branch ${SRCACHE_NGINX_MODULE_VERSION} --single-branch \
    && git clone https://github.com/openresty/redis2-nginx-module.git --branch ${REDIS2_NGINX_MODULE_VERSION} --single-branch \
    && curl https://people.freebsd.org/~osa/ngx_http_redis-${NGX_HTTP_REDIS}.tar.gz | tar xz \
    && git clone https://github.com/vozlt/nginx-module-vts.git --branch ${NGINX_MODULE_VTS_VERSION} --single-branch \
    && curl -L https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xz \
    # Nginx Devel Kit
    && git clone https://github.com/simpl/ngx_devel_kit.git --branch ${NGX_DEVEL_KIT_VERSION} --single-branch \
    # Set Misc Nginx Module
    && git clone https://github.com/openresty/set-misc-nginx-module.git --branch ${SET_MISC_NGINX_MODULE_VERSION} --single-branch \
    # Echo nginx module
    && git clone https://github.com/openresty/echo-nginx-module.git --branch ${ECHO_NGINX_MODULE_VERSION} --single-branch \
    ### Disable Lua module until OpenSSL v1.1 compatible ###
    # && git clone https://github.com/openresty/lua-nginx-module.git --branch ${LUA_NGINX_MODULE_VERSION} --single-branch \
    # && git clone https://luajit.org/git/luajit-2.0.git --branch ${LUAJIT_VERSION} --single-branch \
    # && cd luajit-2.0 \
    # && make \
    # && make install \
    ######
    && cd nginx-${NGINX_VERSION} \
    && ./configure \
        --prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --modules-path=/usr/lib/nginx/modules \
        # Echo
        --add-dynamic-module=../echo-nginx-module \
        # ModSecurity
        --add-module=../ModSecurity-nginx \
        # Brotli
        --add-dynamic-module=../ngx_brotli \
        # nginScript
        --add-dynamic-module=../njs/nginx \
        # SRCache
        --add-dynamic-module=../srcache-nginx-module \
        # Redis2
        --add-dynamic-module=../redis2-nginx-module \
        # HTTP Redis
        --add-dynamic-module=../ngx_http_redis-${NGX_HTTP_REDIS} \
        # virtual host traffic status
        --add-dynamic-module=../nginx-module-vts \
        # Nginx Devel Kit
        --add-dynamic-module=../ngx_devel_kit \
        # Set Misc
        --add-dynamic-module=../set-misc-nginx-module \
        # Lua Module
        #--add-dynamic-module=../lua-nginx-module \
        # Other configs
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/var/cache/nginx/client_temp \
        --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
        --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
        --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
        --user=nginx \
        --group=nginx \
        --with-compat \
        --with-file-aio \
        --with-threads \
        --with-http_addition_module \
        --with-http_auth_request_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_geoip_module=dynamic \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_mp4_module \
        --with-http_perl_module=dynamic \
        --with-http_random_index_module \
        --with-http_realip_module \
        --with-http_secure_link_module \
        --with-http_slice_module \
        --with-http_ssl_module \
        --with-http_stub_status_module \
        --with-http_sub_module \
        --with-http_v2_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-stream \
        --with-stream_realip_module \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module \
        --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' \
        --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie -Wl,-rpath,/usr/local/lib' \
    && make \
    && make install \
    # Install Signature
    && git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git \
    && cp -R ./owasp-modsecurity-crs/rules/ /etc/nginx/ \
    && mv /etc/nginx/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf.example /etc/nginx/rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf \
    && mv /etc/nginx/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf.example /etc/nginx/rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf \
    # Cleanup
    && apt-get purge -y \
        build-essential \
        wget \
        git \
        curl \
        libgeoip-dev \
        libpcre3-dev \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/src/* \
    # Forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY entrypoint.sh /
COPY files/geoip/ /etc/nginx/
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
