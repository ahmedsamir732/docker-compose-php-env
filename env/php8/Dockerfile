FROM php:8.0-fpm
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && pecl install mcrypt-1.0.4 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
	
RUN  apt-get update \
	&& docker-php-ext-install pdo pdo_mysql \
    && apt-get install libzip-dev -y \
	&& docker-php-ext-install zip \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
RUN  echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc

RUN apt-get install -y supervisor

RUN apt-get install -y cron

RUN apt-get update && apt-get install -y libc-client-dev libkrb5-dev && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap


RUN pecl install mongodb-1.9.0

RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

RUN apt-get install -y git

RUN apt-get install -y \
    libxml2-dev \
  && apt-get clean -y \
  && docker-php-ext-install soap

RUN curl -LsS https://codeception.com/releases/2.4.5/codecept.phar -o /usr/local/bin/codecept
RUN chmod a+x /usr/local/bin/codecept

RUN docker-php-ext-install sockets
RUN docker-php-ext-install pcntl

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data
RUN chown www-data /var/www

# USER www-data
# RUN composer global require "fxp/composer-asset-plugin:^1.2.0"

WORKDIR /code
