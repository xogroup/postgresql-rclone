FROM alpine:3.6
MAINTAINER Core Services <coreservices.group@xogrp.com>
LABEL Description="Docker Image based of Alpine 3.6 with Postgresql and Google RClone"

USER root
ENV RCLONE_VERSION=v1.38

RUN apk --update add \
    coreutils \
    postgresql \
    wget \
    ca-certificates \
 && cd /tmp \
 && wget -q https://downloads.rclone.org/rclone-$RCLONE_VERSION-linux-arm64.zip \
 && unzip /tmp/rclone-$RCLONE_VERSION-linux-arm64.zip \
 && cp /tmp/rclone-$RCLONE_VERSION-linux-arm64/rclone /usr/bin \
 && chown root:root /usr/bin/rclone \
 && chmod 755 /usr/bin/rclone \
 && touch /var/log/cron.log \
 && rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

COPY rclone.conf /root/.config/rclone/rclone.conf

CMD ["/usr/sbin/crond", "-f", "-d", "0"]
