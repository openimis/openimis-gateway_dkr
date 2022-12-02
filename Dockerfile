FROM openresty/openresty:bionic
FROM nginx
RUN apt-get update 
ARG TZ=Europe/Brussels
ENV TZ=$TZ
ENV ROOT_API=api
ENV ROOT_ROOT=front
ENV ROOT_RESTAPI=rest
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y tzdata
COPY conf/openimis.conf /conf/openimis.conf
ENV NEW_OPENIMIS_HOST=localhost
ARG NEW_OPENIMIS_HOST=localhost
COPY script /script
ADD certs /etc/nginx/ssl/live/host
RUN mv /etc/nginx/ssl/live/host /etc/nginx/ssl/live/$NEW_OPENIMIS_HOST
RUN chmod a+x /script/entrypoint.sh
WORKDIR /script
ENTRYPOINT ["/bin/bash","/script/entrypoint.sh"]
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]