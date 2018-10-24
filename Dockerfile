FROM nextcloud:apache

RUN apt-get update && apt-get install -y \
  supervisor \
  libsmbclient-dev \
  cron \
  libmcrypt-dev libreadline-dev \
  && pecl install smbclient \
  && pecl install mcrypt-1.0.1 \
  && docker-php-ext-enable mcrypt \
  && docker-php-ext-enable smbclient \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord"]
