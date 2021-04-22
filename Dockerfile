FROM php:7.4.16-fpm-alpine3.13

RUN apk add --no-cache \
        bash \
        zip

# workaround for https://github.com/docker-library/php/issues/240
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN curl -sSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV PATH /fig-website/bin:/fig-website/vendor/bin:${PATH}

# setup user
ARG UID=1000
ARG GID=1000
RUN addgroup -g $GID fig && adduser -D -G fig -u $UID fig \
    && mkdir /fig-website \
    && chown fig:fig /fig-website
WORKDIR /fig-website
USER fig
