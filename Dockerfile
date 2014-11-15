FROM ubuntu:trusty
MAINTAINER Sindre Gulseth <sgulseth@gmail.com>

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -yq install \
        curl \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-imagick \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc \
	git && \
    rm -rf /var/lib/apt/lists/*

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

# Add app
RUN mkdir /app
ADD ./app /app

# Add apache config
ADD apache.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /app

RUN composer install -o --no-dev
RUN chown www-data:www-data /app -R

# By default, simply start apache.
CMD /usr/sbin/apache2ctl -D FOREGROUND
