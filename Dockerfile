FROM debian:jessie

RUN apt-get update \
    && apt-get upgrade --assume-yes \
    && apt-get install --assume-yes --no-install-recommends --no-install-suggests \
        build-essential \
        git \
        libssl-dev \
        libcurl4-openssl-dev \
        python3 \
        python3-dev \
        python3-pip \
        vim \
        zlib1g-dev \
    && ln --symbolic /usr/bin/python3 /usr/bin/python \
    && ln --symbolic /usr/bin/pip3 /usr/bin/pip \
    && pip install --upgrade pip \
    && mkdir /app

RUN gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 \
    && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - \
    && echo 'deb http://deb.torproject.org/torproject.org jessie main' \
      > /etc/apt/sources.list.d/tor.list \
    && apt-get update \
    && apt-get install --assume-yes --no-install-recommends --no-install-suggests \
        tor \
        deb.torproject.org-keyring

COPY . /app
WORKDIR /app

RUN pip install --upgrade --requirement requirements.txt

RUN apt-get remove --assume-yes --purge build-essential \
    && apt-get autoremove --assume-yes \
    && rm --force --recursive --verbose /tmp/* /var/lib/apt/lists/*

EXPOSE 9050
