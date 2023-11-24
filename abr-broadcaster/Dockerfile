FROM httpd
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
  git \
  v4l-utils \
  libasound-dev \
  yasm \
  python3 \
  python3-pip \
  libx264-dev \
  curl \
  nasm \
  ffmpeg \
  libapache2-mod-wsgi
RUN pip3 install webapp2 webob psutil
RUN adduser www-data video
RUN adduser www-data audio


# RUN git clone https://git.ffmpeg.org/ffmpeg.git \
#   && cd ffmpeg \
#   && ./configure --enable-libx264 --enable-gpl \
#   && make -j4 \
#   && make install

RUN git clone https://github.com/jkarthic-akamai/ABR-Broadcaster /app
WORKDIR /app
RUN apt-get install -y sudo
RUN install/abr_broadcaster.sh && install/apache_config.sh /usr/local/apache2/conf/httpd.conf /usr/local/apache2/conf/httpd.conf
