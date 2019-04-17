#!/bin/sh
if [ "$#" -ne 2 ]
then
  echo "Usage: $0 <USER_NAME> <USER_PASSWORD>" >&2
  exit 1
fi
echo -n "$1:" >> /etc/nginx/.htpasswd
openssl passwd $2 >> /etc/nginx/.htpasswd