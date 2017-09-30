FROM abaez/luarocks:openresty

WORKDIR /usr/src/app
COPY . .
RUN apk update \
    && apk add git openssl \
    && wget https://github.com/eit/kong/archive/master.zip \
    && unzip master.zip \
    && cd kong-master \
    && luarocks make kong-0.11.0-0.rockspec \
    && rm -rf /usr/src/app/kong \
    && rm -rf /var/cache/apk/*

COPY bin/kong /bin/

RUN kong migrations up
RUN kong start

EXPOSE 8000 8443 8001 8444

