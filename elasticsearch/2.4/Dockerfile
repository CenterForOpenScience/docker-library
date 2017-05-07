FROM elasticsearch:2.4.4

RUN bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/2.4.4
RUN bin/plugin install lmenezes/elasticsearch-kopf/2.1.2

ENV NODE_DATA=true
ENV NODE_MASTER=true
ENV BOOTSTRAP_MLOCKALL=false
ENV JAVA_OPTS=-Djava.net.preferIPv4Stack=true

# pre-stop-hook.sh and dependencies
RUN apt-get update && apt-get install -y \
    jq \
    curl \
 && rm -rf /var/lib/apt/lists/*
COPY pre-stop-hook.sh /pre-stop-hook.sh

ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
