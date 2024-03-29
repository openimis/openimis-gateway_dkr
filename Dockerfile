FROM openresty/openresty:bionic
RUN apt-get update 
ARG TZ=Europe/Brussels
ENV TZ=$TZ
ENV ROOT_API=api
ENV ROOT_URI=front
ENV ROOT_MOBILEAPI=rest
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y tzdata
COPY conf/openimis.conf /conf/openimis.conf
ENV NEW_OPENIMIS_HOST=localhost
ARG NEW_OPENIMIS_HOST=localhost
COPY script /script
ADD certs /etc/nginx/ssl/live/host
RUN chmod a+x /script/entrypoint.sh
WORKDIR /script
ENTRYPOINT ["/bin/bash","/script/entrypoint.sh"]
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]