FROM elasticsearch:2.3.5

RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:2.3.5

ENV BOOTSTRAP_MLOCKALL=false NODE_DATA=true NODE_MASTER=true JAVA_OPTS=-Djava.net.preferIPv4Stack=true

# pre-stop-hook.sh and dependencies
RUN apt-get update && apt-get install -y \
    jq \
    curl \
 && rm -rf /var/lib/apt/lists/*
COPY pre-stop-hook.sh /pre-stop-hook.sh

ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
