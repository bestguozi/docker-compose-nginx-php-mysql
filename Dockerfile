FROM php:8.2-fpm

RUN docker-php-ext-install \
    pdo_mysql \
    bcmath \
    zip \
    gd \
    file_upload \
    json
    
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN addgroup -g 1000 :www
RUN adduser -G :www -g 'www-data' -s /bin/sh -D www

COPY deploy/conf/* /usr/local/etc/php/

COPY src/ /var/www/html/

RUN chown -R www:www /var/www/html/
