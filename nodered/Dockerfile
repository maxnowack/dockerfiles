FROM nieleyde/rpi-nodered-gpio
RUN npm install node-red-contrib-alexa-home-skill
RUN apt-get update && apt-get install wget make gcc libavahi-compat-libdnssd-dev libbluetooth-dev libcap2-bin
RUN npm install node-red-contrib-eq3-bluetooth
VOLUME ["/root/.node-red", "/data"]
