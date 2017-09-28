FROM abaez/luarocks:openresty

WORKDIR /usr/src/app
COPY . .
RUN apk update \
    && apk add git \
    && git clone https://github.com/eit/kong.git \
    && cd kong \
    && make install \
    && rm -rf /usr/src/app/kong \
    && rm -rf /var/cache/apk/* \

COPY bin/kong /bin/

EXPOSE 8000 8443 8001 8444
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
