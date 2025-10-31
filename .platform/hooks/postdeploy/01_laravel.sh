#!/usr/bin/env bash
set -xe

APP_DIR="/var/app/current"

cd "$APP_DIR"

# Generate APP_KEY if missing
if ! grep -q "^APP_KEY=base64:" .env 2>/dev/null; then
  php artisan key:generate --force
fi

# Storage symlink & caches
php artisan storage:link || true
php artisan config:clear || true
php artisan route:clear || true
php artisan view:clear || true
php artisan config:cache || true
php artisan route:cache || true

# Permissions for Laravel writable dirs
chown -R webapp:webapp storage bootstrap/cache
chmod -R 775 storage bootstrap/cache
