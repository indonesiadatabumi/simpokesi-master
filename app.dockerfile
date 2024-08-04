FROM php:7.3.6-fpm

RUN apt-get -y update \
    && apt-get install -y git libpng-dev libzip-dev libxml2-dev libbz2-dev xvfb wget \
        libxrender1 libfontconfig1 libx11-dev libjpeg62 libxtst6 fontconfig xfonts-75dpi xfonts-base \
        libmcrypt-dev libjpeg62-turbo-dev libfreetype6-dev wkhtmltopdf \
    && docker-php-ext-configure gd \
                --with-freetype-dir=/usr/lib/ \
                --with-png-dir=/usr/lib/ \
                --with-jpeg-dir=/usr/lib/ \
    && docker-php-ext-install mysqli pdo pdo_mysql zip gd mbstring bcmath exif gettext iconv wddx bz2  \
    && docker-php-ext-enable pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/si-mpo-kesi

RUN chmod -R 777 /var/www/si-mpo-kesi
