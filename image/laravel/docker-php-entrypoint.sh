#!/bin/sh

set -eux

cd /app
ls -al

/usr/local/bin/php -v
/usr/local/bin/php artisan migrate --force
# /usr/local/bin/php artisan route:cache
# /usr/local/bin/php artisan config:cache

/usr/bin/crontab docker/crontab

exec supervisord -n
