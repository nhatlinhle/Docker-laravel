#!/bin/bash
cp .env.production .env && composer install && php artisan key:generate && php artisan config:cache && php artisan optimize:clear