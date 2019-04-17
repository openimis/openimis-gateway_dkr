FROM nginx:1.15-alpine
RUN apk update && apk add openssl
COPY conf/openimis.conf /etc/nginx/conf.d/default.conf
COPY script /script
WORKDIR /script
CMD ["nginx", "-g", "daemon off;"]