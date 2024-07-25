FROM alpine:latest
MAINTAINER Nobuo OKAZAKI
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
 && apk add --no-cache tzdata openssh-keygen proftpd-mod_sftp proftpd-utils \
 && rm -rf /tmp/* \
 && mkdir -p /etc/ssh \
 && mkdir -p /run/proftpd \
 && echo /sbin/nologin >> /etc/shells
COPY sftp.conf /etc/proftpd/conf.d
COPY docker-entrypoint.sh /sbin
ENV SFTP_AUTH_METHODS=publickey
EXPOSE 2222
ENTRYPOINT "docker-entrypoint.sh"

