#!/usr/bin/env bash
set -e
cd /var/app/current
php artisan storage:link || true
php artisan migrate --force || true
php artisan config:cache
php artisan route:cache
php artisan view:cache
