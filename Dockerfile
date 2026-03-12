FROM php:8.4-fpm
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
WORKDIR /var/www
COPY . .
RUN cp .env.example .env
RUN composer install --no-dev --optimize-autoloader
RUN php artisan key:generate
RUN chown -R www-data:www-data /var/www
