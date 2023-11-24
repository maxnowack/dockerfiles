FROM debian:stretch
WORKDIR /tmp
RUN apt-get update && apt-get install -y wget build-essential \
  && wget http://downloads.xiph.org/releases/icecast/icecast-2.4.4.tar.gz \
  && tar xf icecast-2.4.4.tar.gz
WORKDIR /tmp/icecast-2.4.4
RUN apt-get install -y libtheora-dev libtheora0 libspeex1 libspeex-dev libxslt1.1 libxslt-dev libvorbis0a libvorbis-dev \
  && ./configure \
  && make \
  && make install \
  && useradd -ms /bin/bash icecast \
  && mkdir -p /usr/local/icecast/logs/ \
  && touch /usr/local/icecast/logs/error.log \
  && touch /usr/local/icecast/logs/access.log \
  && chmod -R 777 /usr/local/icecast/logs \
  && mkdir -p /usr/local/icecast \
  && cp -R web /usr/local/icecast/webroot \
  && cp -R admin /usr/local/icecast/admin
WORKDIR /
RUN rm -rf /tmp/icecast-2.4.4 \
  && rm -rf /tmp/icecast-2.4.4.tar.gz \
  && apt-get remove -y wget build-essential libxslt-dev libvorbis-dev libtheora-dev libspeex-dev \
  && apt-get autoremove -y

EXPOSE 8000
USER icecast
CMD ["icecast", "-c", "/etc/icecast.xml"]
