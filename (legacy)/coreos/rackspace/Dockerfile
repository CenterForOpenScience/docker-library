FROM python:2.7

RUN pip install invoke furl pyrax requests

COPY tasks.py /code/tasks.py

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["--list"]
