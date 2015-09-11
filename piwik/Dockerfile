FROM php:5.6-apache

RUN apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg-dev \
	libpng12-dev \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include \
	&& docker-php-ext-install gd

RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-install mbstring

RUN curl -L -O http://builds.piwik.org/piwik.tar.gz \
    && tar --strip 1 -xzf piwik.tar.gz \
    && rm piwik.tar.gz \
    && chown -R www-data:www-data /var/www/html

RUN echo "always_populate_raw_post_data=-1" >> /usr/local/etc/php/php.ini