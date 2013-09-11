FROM ubuntu:12.10
MAINTAINER Stefan Reinhard "sr@feinheit.ch"
RUN apt-get -qq update
RUN apt-get install -y python-dev python-pip postgresql-server-dev-9.1
RUN pip install virtualenv distribute
RUN virtualenv --no-site-packages /opt/sentry/venv
RUN /opt/sentry/venv/bin/pip install sentry psycopg2
ADD sentry.conf.py /.sentry/
ADD default_admin.json /opt/sentry/
RUN /opt/sentry/venv/bin/sentry upgrade --noinput
RUN /opt/sentry/venv/bin/sentry loaddata /opt/sentry/default_admin.json
EXPOSE 8000:8000
CMD ["/opt/sentry/venv/bin/sentry", "runserver", "0.0.0.0:8000"]