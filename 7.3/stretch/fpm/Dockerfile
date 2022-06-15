FROM php:7.3.29-fpm-stretch
LABEL maintainer="David Lemaitre"

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ghostscript \
        imagemagick \
        locales \
        # Needed for PHP extensions
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxslt-dev \
        libzip-dev \
        # Needed for Composer
        git \
        unzip \
        # Useful tools
        less \
        mariadb-client \
        vim \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
        exif \
        gd \
        intl \
        mysqli \
        opcache \
        pdo_mysql \
        soap \
        xsl \
        zip

# Install PECL extensions
RUN pecl -q install redis \
    && docker-php-ext-enable redis \
    && pecl clear-cache

# Install Composer
ENV COMPOSER_ALLOW_SUPERUSER 1
COPY --from=composer:2.3.7 /usr/bin/composer /usr/bin/composer

# Add custom PHP configuration
COPY php-custom.ini $PHP_INI_DIR/conf.d/

# Set timezone
ENV TZ=Europe/Paris
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata

# Set locale
RUN sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

# Fix permissions
RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data && \
    chown -R www-data:www-data /var/www
