FROM php:7.3.7-fpm-stretch
LABEL maintainer="David Lemaitre"

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    imagemagick \
    mysql-client \
    locales \
    libxml2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libzip-dev \
    libpng-dev \
    zlib1g-dev \
    libicu-dev \
    libcurl4-gnutls-dev \
    libxslt-dev \
    curl \
    git \
    && git config --global http.sslverify false \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    soap \
    intl \
    gd \
    mbstring \
    zip \
    curl \
    json \
    xsl

# Use PECL to install phpredis
ENV PHPREDIS_VERSION 3.1.5
RUN pecl install redis-$PHPREDIS_VERSION \
    && docker-php-ext-enable redis \
    && pecl clear-cache

# Set timezone
ENV TZ=Europe/Paris
RUN echo $TZ > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# Reconfigure locales
RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

RUN echo 'fr_FR.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen


# Install Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
COPY --from=composer:1.6.5 /usr/bin/composer /usr/bin/composer

# Fix permissions
RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data && \
    chown -R www-data:www-data /var/www/html
