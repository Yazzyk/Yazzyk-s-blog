FROM alpine:3.12.0

COPY ./ /www/blog

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache \
  curl \
  git \
  go \
  hugo

ENV VERSION 0.72.0
RUN git clone https://gitee.com/BlankYk/hugo-theme-white.git /www/White \
  && cd /www/blog \
  && hugo

WORKDIR /www/blog

CMD hugo server --bind 0.0.0.0

VOLUME [ "/www/blog" ]

EXPOSE 1313