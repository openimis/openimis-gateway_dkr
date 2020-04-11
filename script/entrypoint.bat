
copy c:\openresty\openIMIS.conf.default C:\openresty\conf\openIMIS.conf
echo "Hosting on https://%NEW_OPENIMIS_HOST%"
perl -pi.orig -e "s/NEW_OPENIMIS_HOST/%NEW_OPENIMIS_HOST%/g;" C:\openresty\conf\openIMIS.conf
perl -pi.orig -e "s/LEGACY_OPENIMIS_HOST/%LEGACY_OPENIMIS_HOST%/g;" C:\openresty\conf\openIMIS.conf
echo "Pointing to legacy openIMIS on https://%LEGACY_OPENIMIS_HOST%"
:: Wait 15 seconds hoping the backend will be up (with cmd there is no good means to check that a service is running)

ping -n 11 ibackend >nul

nginx -g "daemon off;" 