FROM openresty/openresty:bionic
RUN apt-get update && apt-get install -y nano openssl software-properties-common 
RUN add-apt-repository universe
RUN add-apt-repository ppa:certbot/certbot
ARG TZ=Europe/Brussels
ENV TZ=$TZ
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y tzdata
RUN apt-get update && apt-get install -y certbot python-certbot-nginx
RUN luarocks install luajson
COPY lua /lua
# COPY conf/openimis.conf /etc/nginx/conf.d/default.conf
ARG NEW_OPENIMIS_HOST
RUN echo "Hosting on https://"$NEW_OPENIMIS_HOST
RUN sed -i  's/NEW_OPENIMIS_HOST/'$NEW_OPENIMIS_HOST'/g' /etc/nginx/conf.d/default.conf
ARG LEGACY_OPENIMIS_HOST
RUN echo "Pointing to legacy openIMIS on https://"$LEGACY_OPENIMIS_HOST
RUN sed -i  's/LEGACY_OPENIMIS_HOST/'$LEGACY_OPENIMIS_HOST'/g' /etc/nginx/conf.d/default.conf
COPY script /script
RUN sed -i  's/NEW_OPENIMIS_HOST/'$NEW_OPENIMIS_HOST'/g' /script/install-certificate.sh
RUN mkdir -p /etc/ssl/certs
RUN mkdir -p /etc/ssl/private
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt -subj "/C=BE/ST=_/L=_/O=_/OU=_/CN=localhost"
WORKDIR /script
CMD ["openresty", "-g", "daemon off;"]