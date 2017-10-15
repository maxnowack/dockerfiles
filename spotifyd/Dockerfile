FROM resin/rpi-raspbian:jessie

RUN apt-get update -qq
RUN apt-get install -yqq libasound2 libvorbisfile3 curl unzip
RUN curl -LOk `curl --silent https://api.github.com/repos/spotifyd/spotifyd/releases/latest | /usr/bin/awk '/browser_download_url/ { print $2 }' | grep armv7 | /bin/sed 's/"//g'` > /tmp/spotifyd.zip
RUN unzip /*.zip -d /usr/bin

RUN rm /*.zip
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD spotifyd.conf /root/.config/spotifyd/spotifyd.conf

CMD ["/usr/bin/entrypoint.sh"]
