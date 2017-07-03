FROM hypriot/rpi-node:latest
MAINTAINER Max Nowack <max@unsou.de>

RUN apt-get update && apt-get install wget make gcc

WORKDIR /tmp
RUN wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.50.tar.gz
RUN tar xzf bcm2835-1.50.tar.gz
WORKDIR /tmp/bcm2835-1.50
RUN ./configure
RUN make
RUN make install

WORKDIR /opt/fhem-dht
ADD package.json package.json
RUN npm install
ADD app.js app.js
CMD ["npm", "start"]
