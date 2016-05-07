FROM debian:jessie
MAINTAINER cynosure

LABEL Description="This image is used to start the openresty" Version="0.2"

# update mirrors
# RUN rm /etc/apt/sources.list && touch /etc/apt/sources.list
# RUN echo "deb http://mirrors.163.com/debian/ jessie main" >> /etc/apt/sources.list
# RUN echo "deb-src http://mirrors.163.com/debian/ jessie main" >> /etc/apt/sources.list
# RUN echo "deb-src http://mirrors.163.com/debian/ jessie-updates main" >> /etc/apt/sources.list
# RUN echo "deb-src http://mirrors.163.com/debian/ jessie-updates main" >> /etc/apt/sources.list
COPY sources.list /etc/apt/sources.list

# install curl
RUN apt-get -q update && apt-get install -yq --no-install-recommends \
            curl \
            ibreadline-dev \
            libncurses5-dev \
            libpcre3-dev \
            libssl-dev \
            libpq-dev \
            perl \
            make \
            build-essential \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /openresty-1.9.7.4
# install openresty
RUN curl -SL https://openresty.org/download/openresty-1.9.7.4.tar.gz | tar xzvf - -C / &&
    ./configure --prefix=/etc/openresty \
                --with-luajit \
                --without-http_redis2_module \
                --with-http_iconv_module \
                --with-http_postgres_module
    && make && make install && rm -rf openresty-1.9.7.4

EXPOSE 8000
CMD ["/bin/bash"]
ENTRYPOINT ["echo", "Welcome!"]
