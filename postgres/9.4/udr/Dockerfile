FROM postgres:9.4

RUN echo "deb http://packages.2ndquadrant.com/bdr/apt/ wheezy-2ndquadrant main" > /etc/apt/sources.list.d/pgdg-bdr.list

RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -SL "http://packages.2ndquadrant.com/bdr/apt/AA7A6805.asc" | apt-key add -

RUN apt-get update \
    && apt-get install -y postgresql-9.4-udr-plugin \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove curl
