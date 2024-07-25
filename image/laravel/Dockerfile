FROM dunglas/frankenphp:builder-php8.2

ENV DEBIAN_FRONTEND noninteractive
RUN \
    sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \
    sed -i 's/security-cdn.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && \
    apt-get install -y --fix-missing --no-install-recommends \
        vim \
        acl \
        file \
        gettext \
        net-tools \
        git \
        cron \
        supervisor \
        unzip \
        librabbitmq-dev \
        libpq-dev \
	&& rm -rf /var/lib/apt/lists/* \
    ;


RUN set -eux && \
    install-php-extensions \
        @composer \
        apcu \
        intl \
        opcache \
        zip \
        xdebug \
        sockets \
        gd \
        pcntl \
        pdo \
        pdo_mysql \
        redis \
    ;

RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

ARG ROOT_DIR=$ROOT_DIR
# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
# COPY ${ROOT_DIR}/image/laravel/composer-2.7.7.phar /usr/bin/composer
RUN chmod +x /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1

# Set Caddy server name to "http://" to serve on 80 and not 443
# Read more: https://frankenphp.dev/docs/config/#environment-variables
ENV SERVER_NAME="http://"
# If want disable HTTPS, Please use next line
# ENV SERVER_NAME=:80

WORKDIR /app


# Copy the Laravel application files into the container.
COPY ${ROOT_DIR}/projects/api /app

# Copy the container run files into the container.
COPY ${ROOT_DIR}/image/laravel/frankenphp-linux-x86_64 /app/frankenphp
COPY ${ROOT_DIR}/image/laravel/docker-php-entrypoint.sh /usr/local/bin/docker-php-entrypoint
COPY ${ROOT_DIR}/image/laravel/supervisord.conf /etc/supervisor/supervisord.conf
COPY ${ROOT_DIR}/image/laravel/crontab /root/crontab

# Install
RUN composer install

RUN set -eux; \
    cp .env.production .env && \
    chmod 0777 -R bootstrap/cache storage && \
    chmod +x frankenphp && \
    chmod +x /usr/local/bin/docker-php-entrypoint

ENTRYPOINT /usr/local/bin/docker-php-entrypoint

EXPOSE 8000
