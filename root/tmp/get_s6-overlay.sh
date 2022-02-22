#!/bin/sh

if [ -n $ARCH ]
then
  s6_arch=$ARCH
else
  s6_arch="amd64"
fi

case "$s6_arch" in
  arm-v7)
    s6_arch="armhf"
    ;;
  arm64)
    s6_arch="aarch64"
    ;;
  amd64)
    s6_arch="amd64"
    ;;
esac

s6_url="https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz"
echo "Downloading from $s6_url" && \
wget $s6_url -O /tmp/s6-overlay.tar.gz && \
tar xzf /tmp/s6-overlay.tar.gz -C / && \
rm /tmp/s6-overlay.tar.gz && \
echo "Installed s6-overlay v2.2.0.3"

#curl -sX GET "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]' >/etc/S6_RELEASE && \
#v1=`cat /etc/S6_RELEASE`
#v2=${v1//[v]/-}
#
#s6_url="https://github.com/just-containers/s6-overlay/releases/download/$v1/s6-overlay-noarch$v2.tar.xz"
#echo "Downloading from $s6_url" && \
#wget $s6_url -O /tmp/s6-overlay.tar.xz && \
#tar -C / -Jxpf /tmp/s6-overlay.tar.xz && \
#rm /tmp/s6-overlay.tar.xz && \
#echo "Installed s6-overlay $v1 (noarch)"
#
#s6_url="https://github.com/just-containers/s6-overlay/releases/download/$v1/s6-overlay-$s6_arch$v2.tar.xz"
#echo "Downloading from $s6_url" && \
#wget $s6_url -O /tmp/s6-overlay.tar.xz && \
#tar -C / -Jxpf /tmp/s6-overlay.tar.xz && \
#rm /tmp/s6-overlay.tar.xz && \
#echo "Installed s6-overlay $v1 ($s6_arch)"
#
#s6_url="https://github.com/just-containers/s6-overlay/releases/download/$v1/s6-overlay-symlinks-noarch$v2.tar.xz"
#echo "Downloading from $s6_url" && \
#wget $s6_url -O /tmp/s6-overlay.tar.xz && \
#tar -C / -Jxpf /tmp/s6-overlay.tar.xz && \
#rm /tmp/s6-overlay.tar.xz && \
#echo "Installed s6-overlay $v1 (noarch)"
#
#s6_url="https://github.com/just-containers/s6-overlay/releases/download/$v1/s6-overlay-symlinks-arch$v2.tar.xz"
#echo "Downloading from $s6_url" && \
#wget $s6_url -O /tmp/s6-overlay.tar.xz && \
#tar -C / -Jxpf /tmp/s6-overlay.tar.xz && \
#rm /tmp/s6-overlay.tar.xz && \
#echo "Installed s6-overlay $v1 ($s6_arch)"
