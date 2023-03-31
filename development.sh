#!/bin/bash
cp .env.development .env && composer install && php artisan key:generate && php artisan config:cache && php artisan optimize:clear