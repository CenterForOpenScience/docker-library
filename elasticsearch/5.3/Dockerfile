FROM elasticsearch:5.3.1

RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:5.3.1

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
