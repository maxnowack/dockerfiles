FROM debian:stretch
RUN apt-get update && apt-get install -y wget gnupg2 apt-transport-https ca-certificates \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 20D63CCDDD0F62C2 \
  && echo deb http://deb.liquidsoap.info/debian stretch main >> /etc/apt/sources.list.d/liquidsoap.list \
  && apt-get update \
  && wget http://ftp.de.debian.org/debian/pool/non-free/f/fdk-aac/libfdk-aac1_0.1.4-2+b1_amd64.deb \
  && dpkg -i libfdk-aac1_0.1.4-2+b1_amd64.deb \
  && rm -rf libfdk-aac1_0.1.4-2+b1_amd64.deb \
  && apt-get install -y liquidsoap-master \
  libavcodec-extra57 \
  libavfilter-extra6 \
  libavformat57

ENTRYPOINT [ "liquidsoap" ]
