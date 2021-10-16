FROM php:7.1-fpm

RUN apt-get update \
    && apt-get install -y \
    && docker-php-ext-install mysqli pdo_mysql

RUN apt-get update -y \
    && apt-get install -y nginx

WORKDIR /var/www

RUN apt-get update && apt-get install -y libpng-dev
RUN apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir \
    --enable-gd-native-ttf

RUN docker-php-ext-install gd
COPY nginx-site.conf /etc/nginx/sites-enabled/default
COPY index.php /html/index.php
RUN /etc/init.d/nginx start
EXPOSE 80 443
CMD ["php-fpm"]

