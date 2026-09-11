#!/bin/bash
set -e

echo "Starting Web-License & Nginx..."

export NGINX_PORT=3000

cd /usr/local/x-ui

echo "Applying 3x-ui settings..."
./x-ui setting -port 8088 -webBasePath /dashboard/ || true

echo "Generating nginx.conf from template..."
envsubst '${NGINX_PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo "Starting Web-License..."
./x-ui &

sleep 2

echo "Starting Nginx..."
nginx -t
exec nginx -g "daemon off;"
