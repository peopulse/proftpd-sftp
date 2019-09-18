FROM alpine:3.10
MAINTAINER Nobuo OKAZAKI
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
 && apk add --no-cache tzdata openssh-keygen proftpd-mod_sftp proftpd-mod_auth_file proftpd-utils \
 && rm -rf /tmp/* \
 && mkdir -p /run/proftpd \
 && echo /sbin/nologin >> /etc/shells
COPY sftp.conf /etc/proftpd/conf.d
COPY docker-entrypoint.sh /sbin
ENV SFTP_AUTH_METHODS=publickey
EXPOSE 2222
ENTRYPOINT "docker-entrypoint.sh"

