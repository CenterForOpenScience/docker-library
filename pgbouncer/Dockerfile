FROM alpine:3.14

ENV PGBOUNCER_VERSION=1.16.0 \
    PGBOUNCER_SHA256=a4a391618bb83caaee2a8cd9653974f4c1b98b95987d5cabbbeb801da6342652

RUN addgroup -S pgbouncer \
    && adduser -D -S -s /sbin/nologin -G pgbouncer pgbouncer \
    && apk add --no-cache --virtual .run-deps \
      c-ares \
      libevent \
      libressl

RUN apk add --no-cache --virtual .build-deps \
      build-base \
      autoconf \
      wget \
      c-ares-dev \
      libevent-dev \
      libressl-dev \
    && wget https://pgbouncer.github.io/downloads/files/$PGBOUNCER_VERSION/pgbouncer-$PGBOUNCER_VERSION.tar.gz \
    && echo "$PGBOUNCER_SHA256  /pgbouncer-$PGBOUNCER_VERSION.tar.gz" | sha256sum -c - \
    && tar -xzvf pgbouncer-$PGBOUNCER_VERSION.tar.gz \
    && cd pgbouncer-$PGBOUNCER_VERSION \
    && ./configure --prefix=/usr --disable-debug \
    && make \
    && make install \
    && mkdir /etc/pgbouncer \
    && cp ./etc/pgbouncer.ini /etc/pgbouncer/ \
    && touch /etc/pgbouncer/userlist.txt \
    && sed -i \
      -e "s|logfile = |#logfile = |" \
      -e "s|pidfile = |#pidfile = |" \
      -e "s|listen_addr = .*|listen_addr = 0.0.0.0|" \
      -e "s|auth_type = .*|auth_type = md5|" \
      /etc/pgbouncer/pgbouncer.ini \
    && cd .. \
    && rm pgbouncer-$PGBOUNCER_VERSION.tar.gz \
    && rm -rf pgbouncer-$PGBOUNCER_VERSION \
    && apk del .build-deps

CMD ["pgbouncer", "-u", "pgbouncer", "/etc/pgbouncer/pgbouncer.ini"]
