FROM debian:bullseye-slim

LABEL MAINTAINER="Rami Sfari <rami2gmail@gamil.com>"

# Install required packages and remove the apt packages cache when done.
RUN apt update \
  && apt install --no-install-recommends --no-install-suggests -y python3.8 \
	python3-dev python-setuptools libpcre3 libpcre3-dev python3-pip software-properties-common \
	nginx \
	curl libpq-dev gcc libpq-dev libjpeg-dev zlib1g-dev \
	supervisor \
  && apt-get clean

# Which uWSGI .ini file should be used, to make it customizable
ENV UWSGI_INI /app/uwsgi.ini

# replace nginx config with custom one
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# setup supervisor config
COPY ./supervisor/supervisor.conf /etc/supervisor/conf.d/

# Create New user & group
RUN groupadd -r www-nginx && useradd -r -g www-nginx nginx

## add permissions for nginx user
RUN touch /var/run/nginx.pid && \
  chown -R nginx:www-nginx /var/lib/nginx /var/run/nginx.pid /var/log/nginx

EXPOSE 8080

CMD ["supervisord", "-n"]
