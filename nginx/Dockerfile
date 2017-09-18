FROM debian:stretch-slim

# ModSecurity
ENV MODSECURITY_VERSION=v3/master \
    MODSECURITY_NGINX_VERSION=master \
    NGINSCRIPT_VERSION=0.1.11 \
    NGX_BROTLI_VERSION=master \
    NGINX_VERSION=1.13.1

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
        libperl-dev \
    && cd /usr/src \
    # Create log and cache directories
    && mkdir -p \
        /var/log/nginx \
        /var/cache/nginx \
    && git clone https://github.com/SpiderLabs/ModSecurity.git --branch ${MODSECURITY_VERSION} --single-branch \
    && cd ModSecurity \
    && sh build.sh \
    && git submodule update --init \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && git clone https://github.com/SpiderLabs/ModSecurity-nginx.git --branch ${MODSECURITY_NGINX_VERSION} --single-branch \
    && git clone https://github.com/nginx/njs.git --branch ${NGINSCRIPT_VERSION} --single-branch \
    && git clone https://github.com/google/ngx_brotli.git --branch ${NGX_BROTLI_VERSION} --single-branch \
    && cd ngx_brotli \
    && git submodule update --init \
    && cd /usr/src \
    && curl -L https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xz \
    && cd nginx-${NGINX_VERSION} \
    && ./configure \
        --prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --modules-path=/usr/lib/nginx/modules \
        # ModSecurity
        --add-module=../ModSecurity-nginx \
        # Brotli
        --add-dynamic-module=../ngx_brotli \
        # nginScript
        --add-dynamic-module=../njs/nginx \
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
        --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' \
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
        g++ \
        curl \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/src/* \
    # Forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
