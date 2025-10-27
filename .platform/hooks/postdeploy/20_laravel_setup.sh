#!/usr/bin/env bash
set -e
cd /var/app/current

# 1) .env ?? ?? ?????
if [ ! -f .env ]; then
  cp -f .env.example .env || true
fi

# 2) APP_KEY ?? ????/?? ?????
if ! grep -q '^APP_KEY=' .env || grep -q '^APP_KEY=$' .env; then
  php artisan key:generate --force || true
fi

# 3) ???????
chown -R webapp:nginx storage bootstrap/cache || true
find storage bootstrap/cache -type d -exec chmod 775 {} \; || true
find storage bootstrap/cache -type f -exec chmod 664 {} \; || true

# 4) ????? ????
php artisan storage:link || true
php artisan config:clear || true
php artisan route:clear  || true
php artisan view:clear   || true
php artisan cache:clear  || true

# ????? ??? ?? ?????? ?????
php artisan config:cache || true
php artisan route:cache  || true
php artisan view:cache   || true
