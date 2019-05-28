FROM nginx:1.15-alpine
RUN apk update && apk add openssl
COPY conf/openimis.conf /etc/nginx/conf.d/default.conf
ARG LEGACY_OPENIMIS_HOST
RUN echo "Pointing to legacy openIMIS on "$LEGACY_OPENIMIS_HOST
RUN sed -i  's/LEGACY_OPENIMIS_HOST/'$LEGACY_OPENIMIS_HOST'/g' /etc/nginx/conf.d/default.conf
COPY script /script
WORKDIR /script
CMD ["nginx", "-g", "daemon off;"]