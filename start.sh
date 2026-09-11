#!/bin/bash
set -e

echo "Starting LicenceWebsite"

export NGINX_PORT=9639

cd /usr/local/x-ui

echo "Applying Settings..."
./x-ui setting -port 8088 -webBasePath /dashboard/ || true

echo "Generating nginx.conf from template..."
envsubst '${NGINX_PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "Starting All ..."
./x-ui &

sleep 2

echo "Starting Nginx..."
nginx -t
exec nginx -g "daemon off;"
