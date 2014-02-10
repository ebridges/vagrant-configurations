#!/bin/sh

HOST=$1
UPSTREAM_1=$2
UPSTREAM_2=$3
CONFIG='/etc/nginx/sites-available/default'

echo "Provisioning load balancer configuration"
(
cat <<EOF
upstream cluster {
  server ${UPSTREAM_1};
  server ${UPSTREAM_2};
}

server {
  listen 80;
  server_name ${HOST};

  location / {
    proxy_pass_header Host;
    proxy_pass http://cluster; 
  }
}
EOF
) > $CONFIG

/etc/init.d/nginx restart

