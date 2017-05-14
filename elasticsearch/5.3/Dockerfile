FROM elasticsearch:5.3.1

RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:5.3.1

ENV BOOTSTRAP_MEMORY_LOCK=false
ENV ES_JAVA_OPTS=-Djava.net.preferIPv4Stack=true

# common dependencies
RUN apt-get update && apt-get install -y \
        jq \
        curl \
    && rm -rf /var/lib/apt/lists/*

ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
