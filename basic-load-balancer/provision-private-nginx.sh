#!/bin/sh

HOST=$1
CONFIG='/etc/nginx/sites-available/default'
DOCROOT='/var/www/nginx-default'

mkdir -p ${DOCROOT}

echo "Provisioning default home page for ${HOST}"
(
cat <<EOF
<html>
  <body>
    <h3>Host: ${HOST}</h3>
  </body>
</html>
EOF
) > ${DOCROOT}/index.html

echo "Provisioning private server configuration for ${HOST}"
(
cat <<EOF
server {
  listen 80;
  server_name ${HOST};

  location / {
    root   ${DOCROOT};
    index  index.html index.htm;
  }
}
EOF
) > $CONFIG

/etc/init.d/nginx restart 
