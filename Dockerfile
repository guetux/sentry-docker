FROM ubuntu:12.10
MAINTAINER Stefan Reinhard "sr@feinheit.ch"
RUN apt-get -qq update
RUN apt-get install -y python-dev python-pip
RUN pip install virtualenv distribute
RUN virtualenv --no-site-packages /opt/sentry/venv
ADD sentry.conf.py /.sentry/
ADD pip.conf /.pip/
ADD requirements.txt /opt/sentry/
ADD default_admin.json /opt/sentry/
RUN /opt/sentry/venv/bin/pip install -r /opt/sentry/requirements.txt
RUN /opt/sentry/venv/bin/sentry upgrade --noinput
RUN /opt/sentry/venv/bin/sentry loaddata /opt/sentry/default_admin.json
EXPOSE 8000:8000
CMD ["/opt/sentry/venv/bin/sentry", "runserver", "0.0.0.0:8000"]