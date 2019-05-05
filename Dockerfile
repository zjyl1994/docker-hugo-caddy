FROM abiosoft/caddy
LABEL maintainer "zjyl1994 <me@zjyl1994.com>"

ENV HUGO_VERSION=0.55.5
ENV HUGO_TYPE=_extended
ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}
ENV REPO=github.com/zjyl1994/blog

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}_Linux-64bit.tar.gz /tmp

RUN apk add --no-cache openssh-client git tar tzdata ca-certificates libc6-compat libgcc libstdc++ \
  && tar -xf /tmp/${HUGO_ID}_Linux-64bit.tar.gz -C /tmp \
  && mv /tmp/hugo /usr/bin/hugo \
  && chmod 0755 /usr/bin/hugo \
  && git config --global fetch.recurseSubmodules true \
  && mkdir -p /www/public \
  && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
  && rm -rf /tmp/${HUGO_ID}_Linux-64bit.tar.gz \
  && rm -rf /tmp/LICENSE \
  && rm -rf /tmp/README.md

WORKDIR /www

COPY Caddyfile /etc/Caddyfile