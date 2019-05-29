FROM nginx:1.15
RUN apt-get update && apt-get install -y openssl certbot python-certbot-nginx
COPY conf/openimis.conf /etc/nginx/conf.d/default.conf
ARG NEW_OPENIMIS_HOST
RUN echo "Hosting on https://"$NEW_OPENIMIS_HOST
RUN sed -i  's/NEW_OPENIMIS_HOST/'$NEW_OPENIMIS_HOST'/g' /etc/nginx/conf.d/default.conf
ARG LEGACY_OPENIMIS_HOST
RUN echo "Pointing to legacy openIMIS on https://"$LEGACY_OPENIMIS_HOST
RUN sed -i  's/LEGACY_OPENIMIS_HOST/'$LEGACY_OPENIMIS_HOST'/g' /etc/nginx/conf.d/default.conf
COPY script /script
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /ssl/localhost.key -out /ssl/localhost.crt -subj "/C=BE/ST=_/L=_/O=_/OU=_/CN=localhost"
WORKDIR /script
CMD ["nginx", "-g", "daemon off;"]