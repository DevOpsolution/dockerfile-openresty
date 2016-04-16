FROM debian:jessie
MAINTAINER cynosure

LABEL Description="This image is used to start the openresty" Version="0.1"

# update mirrors
RUN rm /etc/apt/sources.list && touch /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/debian/ jessie main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ jessie main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ jessie-updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ jessie-updates main" >> /etc/apt/sources.list


# install curl
RUN apt-get -q update && apt-get install -yq curl


# install dev lib dep
RUN apt-get install -yq libreadline-dev \
            libncurses5-dev \
            libpcre3-dev \
            libssl-dev \
            libpq-dev \
            perl \
            make \
            build-essential

# install openresty
RUN curl -SL https://openresty.org/download/openresty-1.9.7.4.tar.gz | tar xzvf - -C /
WORKDIR /openresty-1.9.7.4
RUN ./configure --prefix=/etc/openresty \
                --with-luajit \
                --without-http_redis2_module \
                --with-http_iconv_module \
                --with-http_postgres_module
RUN make && make install

EXPOSE 8000

CMD ["/bin/bash"]
