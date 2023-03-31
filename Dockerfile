# Sử dụng ảnh php 7.4-fpm của Docker Hub
FROM php:8.0-fpm

# Cài đặt các extension cần thiết cho Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install \
    zip \
    pdo_mysql

# Sao chép mã nguồn của Laravel vào container
COPY . /var/www/html

# Thiết lập quyền truy cập thư mục của Laravel cho nginx và Apache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Thiết lập thư mục làm việc của container
WORKDIR /var/www/html

# Thiết lập biến môi trường cho Laravel
ENV APP_NAME="Laravel Docker" \
    APP_ENV=local \
    APP_KEY= \
    APP_DEBUG=true \
    APP_URL=http://localhost \
    LOG_CHANNEL=stack \
    DB_CONNECTION=mysql \
    DB_HOST=db \
    DB_PORT=3306 \
    DB_DATABASE=laravel \
    DB_USERNAME=laravel \
    DB_PASSWORD=laravel

# Cài đặt Composer và các package của Laravel
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --prefer-dist --no-scripts --no-dev --no-autoloader --no-progress --no-suggest

# Tạo file .env của Laravel
RUN cp .env.example .env \
    && php artisan key:generate \
    && php artisan config:cache

# Thiết lập quyền truy cập cho các file và thư mục của Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Thiết lập thư mục làm việc cho container
WORKDIR /var/www/html/public

# Mở cổng 9000 để sử dụng với php-fpm
EXPOSE 9000

# Chạy các lệnh cần thiết để chạy Laravel
CMD ["php-fpm"]