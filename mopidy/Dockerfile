FROM debian:buster
RUN apt-get update \
  && apt-get install -y wget gnupg2 \
  && wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - \
  && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list \
  && apt-get update \
  && apt-get install -y build-essential \
    python3-dev \
    python3-pip \
    python-spotify \
    python3-gst-1.0 \
    gir1.2-gstreamer-1.0 \
    gir1.2-gst-plugins-base-1.0 \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-tools \
    libspotify12 \
    libspotify-dev \
  && pip3 install mopidy \
  && pip3 install Mopidy-MPD \
  && pip3 install Mopidy-Spotify \
  && pip3 install Mopidy-Iris \
  && pip3 install Mopidy-SoundCloud \
  && echo "mopidy ALL=NOPASSWD: /usr/local/lib/python3.7/dist-packages/mopidy_iris/system.sh" >> /etc/sudoers \
  && mkdir -p /home/mopidy/media

COPY mopidy.conf /root/.config/mopidy_default.conf
COPY start.sh /usr/local/bin/start.sh

EXPOSE 6600 6680
ENTRYPOINT ["/usr/local/bin/start.sh"]
