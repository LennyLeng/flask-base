
FROM ubuntu:14.04

MAINTAINER Lenny Leng <admin@lennyleng.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install nginx python-pip python-dev uwsgi-plugin-python supervisor


RUN mkdir -p /var/log/nginx/app
RUN mkdir -p /var/log/uwsgi/app


RUN rm /etc/nginx/sites-enabled/default

COPY flask.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/flask.conf /etc/nginx/sites-enabled/flask.conf

COPY uwsgi.ini /var/www/app/


RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN pip install uwsgi flask
copy app /var/www/app

CMD ["/usr/bin/supervisord"]
