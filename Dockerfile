FROM php:8.0-fpm-bullseye

# Basic
WORKDIR /usr/share/nginx/html
ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt update && apt -y dist-upgrade

# Base Requirements Packages
RUN apt install -y build-essential software-properties-common wget curl git nano zip

# Deps
RUN apt install --no-install-recommends -y libicu-dev gnupg apt-transport-https libcurl4 libzip4 libzip-dev libonig-dev libonig5 libcurl4-gnutls-dev libxml2-dev unixodbc-dev libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev zlib1g-dev libicu-dev g++ unixodbc-dev && ACCEPT_EULA=Y apt install --no-install-recommends -y libxml2-dev libaio-dev libmemcached-dev freetds-dev libssl-dev openssl

# Install Basic PHP Extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql zip intl iconv sockets curl xml mbstring gd opcache

# Enable Basic PHP Extensions
RUN docker-php-ext-enable pdo_mysql zip intl

# Install Xdebug and Redis
RUN pecl install xdebug redis

# Enable Xdebug and Redis
RUN docker-php-ext-enable xdebug redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clean
RUN apt autoremove -y && apt clean && rm -rf /var/lib/apt/lists/*