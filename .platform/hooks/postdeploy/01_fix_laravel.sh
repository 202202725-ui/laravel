#!/bin/bash
cd /var/app/current

# Fix permissions
sudo chown -R webapp:webapp /var/app/current
sudo chmod -R 755 /var/app/current

# Laravel optimization commands
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan storage:link
php artisan migrate --force || true
