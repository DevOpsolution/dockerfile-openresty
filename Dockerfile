FROM debian
MAINTAINER cynosure

LABEL Description="This image is used to start the openresty" Version="0.1"
# install curl
RUN apt-get -q update && apt-get install -yq curl

# install dev lib dep
RUN apt-get install -yp libreadline-dev \
            libncurses5-dev \
            libpcre3-dev \
            libssl-dev \
            perl \
            make \
            build-essential \

# install openresty
RUN curl -SL https://openresty.org/download/openresty-1.9.7.4.tar.gz | tar xzvf - -C / \
    && cd openresty* \
    && ./configure --prefix=/etc/openresty \
                   --with-luajit \
                   --without-http_redis2_module \
                   --with-http_iconv_module \
                   --with-http_postgres_module

EXPOSE 8000

CMD ["/bin/bash"]
