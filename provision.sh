#!/bin/bash
set -e

echo "--- Starting server provisioning ---"

echo "--- Updating packages ---"
sudo apt update -y
sudo apt upgrade -y

echo "--- Installing nginx ---"
sudo apt install -y nginx

echo "--- Copying nginx config ---"
sudo cp ~/my-infrastructure/nginx.conf /etc/nginx/sites-available/roosterworks.org
sudo ln -s /etc/nginx/sites-available/roosterworks.org /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default

echo "--- Writing index.html ---"
sudo bash -c 'cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
  <head><title>Provisioned Server</title></head>
  <body>
    <h1>Roosterworks - Red Version</h1>
    <p>This page was created by a shell script.</p>
  </body>
</html>
EOF'

echo "--- Testing nginx config ---"
sudo nginx -t

echo "--- Reloading nginx ---"
sudo systemctl reload nginx

echo "--- Provisioning complete ---"
