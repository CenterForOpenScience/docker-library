FROM elasticsearch:5.0.1

RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:5.0.1

ENV BOOTSTRAP_MLOCKALL=false
ENV NODE_DATA=true
ENV NODE_MASTER=true
ENV ES_JAVA_OPTS=-Djava.net.preferIPv4Stack=true

# pre-stop-hook.sh and dependencies
RUN apt-get update && apt-get install -y \
    jq \
    curl \
 && rm -rf /var/lib/apt/lists/*
COPY pre-stop-hook.sh /pre-stop-hook.sh

ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
