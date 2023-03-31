# Sử dụng ảnh php 8.0-fpm của Docker Hub
FROM php:8.0-fpm

# Set thư mục default khi connect tới container
WORKDIR /var/www

# Cài đặt những extension cần thiết cho laravel
RUN apt-get update && apt-get install -y  --no-install-recommends libpq-dev libmagickwand-dev ghostscript \
  build-essential \
  libpng-dev \
  libjpeg62-turbo-dev \
  libfreetype6-dev \
  locales \
  zip \
  jpegoptim optipng pngquant gifsicle \
  vim \
  unzip \
  git \
  curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Cài đặt extensions
RUN docker-php-ext-install pdo_mysql pdo_pgsql gd

# Cài đặt composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Mở cổng 9000 để sử dụng với php-fpm
EXPOSE 9000

CMD ["php-fpm"]