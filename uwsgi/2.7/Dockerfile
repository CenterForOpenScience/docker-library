FROM python:2.7

RUN usermod -d /home www-data \
    && chown www-data:www-data /home

RUN pip install uwsgi==2.0.10

CMD ["uwsgi", "--ini", "/etc/uwsgi/uwsgi.ini"]
