FROM debian:bullseye-slim

LABEL MAINTAINER="Rami Sfari <rami2gmail@gamil.com>"

# Install required packages and remove the apt packages cache when done.
RUN apt update && apt install --no-install-recommends --no-install-suggests -y python3.9 python3-dev python3-pip \
      python-setuptools software-properties-common \
      libpq-dev libjpeg-dev zlib1g-dev \
      libpcre3 libpcre3-dev \
      nginx \
      supervisor && rm -rf /var/lib/apt/lists/*
