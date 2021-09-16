#!/bin/bash
set -e
rm -f /etc/nginx/conf.d/openIMIS.conf
rm -f /etc/nginx/conf.d/default.conf
cp  /script/default.conf /etc/nginx/conf.d/openIMIS.conf
echo "Hosting on https://""$NEW_OPENIMIS_HOST"
sed -i 's|NEW_OPENIMIS_HOST|'"$NEW_OPENIMIS_HOST"'|g' /etc/nginx/conf.d/openIMIS.conf
echo "Pointing to legacy openIMIS on https://""$LEGACY_OPENIMIS_HOST"
sed -i 's|LEGACY_OPENIMIS_HOST|'"$LEGACY_OPENIMIS_HOST"'|g' /etc/nginx/conf.d/openIMIS.conf
if [ -e "/etc/letsencrypt/live/$NEW_OPENIMIS_HOST/fullchain.pem" ]; then
  sed -i  "s/\/etc\/ssl\/certs\/localhost\.crt/\/etc\/letsencrypt\/live\/$NEW_OPENIMIS_HOST\/fullchain\.pem/g" /etc/nginx/conf.d/openIMIS.conf
  sed -i  "s/\/etc\/ssl\/private\/localhost\.key/\/etc\/letsencrypt\/live\/$NEW_OPENIMIS_HOST\/privkey\.pem/g" /etc/nginx/conf.d/openIMIS.conf
fi
exec "$@"
