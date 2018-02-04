FROM sentry:8.22

ADD ./append-sentry.conf.py /etc/sentry/

RUN pip install https://github.com/getsentry/sentry-auth-google/archive/52020f577f587595fea55f5d05520f1473deaad1.zip \
    && cd /etc/sentry \
    && cat append-sentry.conf.py >> sentry.conf.py \
    && rm append-sentry.conf.py
