FROM ubuntu:16.04

ARG DANTE_VER=1.4.2
ARG DANTE_URL=https://www.inet.no/dante/files/dante-$DANTE_VER.tar.gz
ARG DANTE_SHA=4c97cff23e5c9b00ca1ec8a95ab22972813921d7fbf60fc453e3e06382fc38a7
ARG DANTE_FILE=dante.tar.gz
ARG DANTE_TEMP=dante
ARG DANTE_DEPS="build-essential curl wget dirmngr apt-transport-https lsb-release ca-certificates"
ARG DUMBINIT_VERSION=1.2.2

RUN set -xe \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y $DANTE_DEPS \
  && mkdir $DANTE_TEMP \
    && cd $DANTE_TEMP \
    && curl -sSL $DANTE_URL -o $DANTE_FILE \
    && echo "$DANTE_SHA *$DANTE_FILE" | shasum -c \
    && tar xzf $DANTE_FILE --strip 1 \
    && ./configure \
    && make install \
    && cd .. \
    && rm -rf $DANTE_TEMP \
  && rm -rf /var/lib/apt/lists/* \
  && wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg | apt-key add - \
  && echo "deb http://build.openvpn.net/debian/openvpn/stable xenial main" > /etc/apt/sources.list.d/openvpn-aptrepo.list \
  && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
  && apt-get install -y openvpn nodejs \
  && wget https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_amd64.deb \
  && dpkg -i dumb-init_${DUMBINIT_VERSION}_amd64.deb \
  && rm -rf dumb-init_${DUMBINIT_VERSION}_amd64.deb

ADD sockd.conf /etc/sockd.conf
ADD openvpn/ /etc/openvpn/
ADD proxy/ /proxy/

ENV WORKERS 10
EXPOSE 1080
EXPOSE 3000

CMD ["dumb-init", "/etc/openvpn/start.sh"]
