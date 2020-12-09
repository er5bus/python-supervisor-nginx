FROM debian:bullseye-slim

LABEL MAINTAINER="Rami Sfari <rami2gmail@gamil.com>"

# Install required packages and remove the apt packages cache when done.
RUN apt update && apt install --no-install-recommends --no-install-suggests -y python3.8 python3-dev python3-pip \
      python-setuptools software-properties-common \
      curl gcc libpq-dev libjpeg-dev zlib1g-dev \
      libpcre3 libpcre3-dev \
      nginx \
      supervisor && rm -rf /var/lib/apt/lists/*

# Which uWSGI .ini file should be used, to make it customizable
ENV UWSGI_INI /app/uwsgi.ini

# replace nginx config with custom one
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# setup supervisor config
COPY ./supervisor/supervisor.conf /etc/supervisor/conf.d/

# Create New user & group for nginx
RUN groupadd -r www-nginx && useradd -r -g www-nginx nginx

## add permissions for nginx user
RUN touch /var/run/nginx.pid && \
chown -R nginx:www-nginx /var/lib/nginx /var/run/nginx.pid /var/log/nginx
