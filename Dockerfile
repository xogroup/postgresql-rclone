# FROM alpine:3.6
# MAINTAINER Vlad Carballo <vcarballo@xogrp.com>
# LABEL Description="Docker Image based of Alpine 3.6 with Postgresql and Google RClone"
#
#
# USER root
#
# RUN apk --update add \
#     postgresql \
#  && rm -rf /var/cache/apk/*
#
# RUN touch /var/log/cron.log
#
# CMD ["/usr/sbin/crond", "-f", "-d", "0"]

FROM alpine:3.6

ENV RCLONE_VERSION=v1.38

RUN apk --update add \
    wget \
    ca-certificates \
 && cd /tmp \
 && wget -q https://downloads.rclone.org/rclone-$RCLONE_VERSION-linux-arm64.zip \
 && unzip /tmp/rclone-$RCLONE_VERSION-linux-arm64.zip \
 && cp /tmp/rclone-$RCLONE_VERSION-linux-arm64/rclone /usr/bin \
 && chown root:root /usr/bin/rclone \
 && chmod 755 /usr/bin/rclone \
 && rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

CMD ["/usr/bin/rclone", "--version"]
