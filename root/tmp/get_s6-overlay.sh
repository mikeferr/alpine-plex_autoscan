#!/bin/sh

case ${ARCH} in
  arm-v7)
    ARCH="armhf"
    ;;
  arm64)
    ARCH="aarch64"
    ;;
  amd64)
    ARCH="amd64"
    ;;
esac
echo $ARCH
curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]' >/etc/S6_RELEASE && \
echo "Dowloading from https://github.com/just-containers/s6-overlay/releases/download/`cat /etc/S6_RELEASE`/s6-overlay-${ARCH}.tar.gz" && \
wget https://github.com/just-containers/s6-overlay/releases/download/`cat /etc/S6_RELEASE`/s6-overlay-${ARCH}.tar.gz -O /tmp/s6-overlay.tar.gz && \
tar xzf /tmp/s6-overlay.tar.gz -C / && \
rm /tmp/s6-overlay.tar.gz && \
echo "Installed s6-overlay `cat /etc/S6_RELEASE` ($ARCH)"
