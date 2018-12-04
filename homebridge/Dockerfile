FROM maxnowack/rpi-homebridge
MAINTAINER Max Nowack <max@unsou.de>

EXPOSE 2001 5353 9090 51826

RUN apt-get update && apt-get install wget make gcc libavahi-compat-libdnssd-dev libbluetooth-dev libcap2-bin libpcap-dev
RUN npm i -g --unsafe-perm noble
RUN setcap cap_net_raw+eip $(eval readlink -f `which node`)

WORKDIR /tmp
RUN wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.50.tar.gz && tar xzf bcm2835-1.50.tar.gz
WORKDIR /tmp/bcm2835-1.50
RUN ./configure && make && make install

WORKDIR /usr/local/homebridge

RUN npm i -g --unsafe-perm homebridge-fhem
RUN npm i -g --unsafe-perm homebridge-dht-sensor@2.1.2
RUN npm i -g --unsafe-perm homebridge-yeelight-wifi
RUN npm i -g --unsafe-perm homebridge-alexa
RUN npm i -g --unsafe-perm homebridge-xbox-one
RUN npm i -g --unsafe-perm homebridge-apple-tv
