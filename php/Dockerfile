FROM php:7.4-apache
RUN apt-get update && apt-get install -y \
  libzip-dev \
  zip \
  && docker-php-ext-configure zip \
  && docker-php-ext-install zip
RUN docker-php-ext-install -j$(nproc) mysqli \
  && docker-php-ext-install -j$(nproc) pdo \
  && docker-php-ext-install -j$(nproc) pdo_mysql
RUN echo "upload_max_filesize = 4G" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "memory_limit = 4G" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "post_max_size = 4G" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "max_execution_time = 9000" >> /usr/local/etc/php/conf.d/custom.ini
