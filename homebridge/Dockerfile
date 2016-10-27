FROM spybyte/rpi-homebridge:latest
MAINTAINER Max Nowack <max@unsou.de>

EXPOSE 2001 5353 9090 51826

RUN apt-get update && apt-get install git-core wget make gcc
WORKDIR /tmp
#RUN git clone git://git.drogon.net/wiringPi
#WORKDIR /tmp/wiringPi
#RUN ./build

WORKDIR /tmp
RUN wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.50.tar.gz
RUN tar xzf bcm2835-1.50.tar.gz
WORKDIR /tmp/bcm2835-1.50
RUN ./configure
RUN make
RUN make install


RUN npm install -g --unsafe-perm homebridge-fhem
RUN npm install -g --unsafe-perm homebridge-dht-sensor@bcm2835

WORKDIR /usr/local/homebridge
ADD config.json ~/.homebridge/config.json