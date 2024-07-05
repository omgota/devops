FROM php:7.4-fpm

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Установка расширений PHP
RUN docker-php-ext-install exif pcntl bcmath gd xml xsl soap pdo_pgsql mbstring intl opcache sockets

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Установка Laravel
WORKDIR /var/www/html
COPY . /var/www/html
RUN composer install

# Права на папку
RUN chown -R www-data:www-data /var/www/html

# Открытие порта 9000
EXPOSE 9000
CMD ["php-fpm"]
