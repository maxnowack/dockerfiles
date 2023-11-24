FROM maxnowack/rpi-homebridge

EXPOSE 2001 5353 9090 51826

WORKDIR /tmp
RUN apt-get update && apt-get install -y wget make gcc
RUN wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.50.tar.gz && tar xzf bcm2835-1.50.tar.gz
WORKDIR /tmp/bcm2835-1.50
RUN ./configure && make && make install

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev libbluetooth-dev libcap2-bin libpcap-dev
RUN npm i -g --unsafe-perm noble
RUN setcap cap_net_raw+eip $(eval readlink -f `which node`)

WORKDIR /usr/local/homebridge

RUN npm i -g --unsafe-perm homebridge-yeelighter
RUN npm i -g --unsafe-perm homebridge-tuya-web
