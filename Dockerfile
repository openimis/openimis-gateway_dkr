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
RUN mkdir -p /etc/ssl/certs
RUN mkdir -p /etc/ssl/private
COPY conf/openimis.conf /script/default.conf
#COPY conf/openimis.conf /etc/nginx/conf.d/default.conf
ENV NEW_OPENIMIS_HOST = ""
ENV LEGACY_OPENIMIS_HOST = ""
COPY script /script

RUN chmod a+x /script/entrypoint.sh
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt -subj "/C=BE/ST=_/L=_/O=_/OU=_/CN=localhost"
WORKDIR /script
ENTRYPOINT ["/bin/bash","/script/entrypoint.sh"]
CMD ["openresty", "-g", "daemon off;"]
