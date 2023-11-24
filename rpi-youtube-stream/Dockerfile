# FROM debian AS ffmpeg
# ENTRYPOINT []

# RUN apt-get update -qy && apt-get -qy install \
#   build-essential \
#   git \
#   libomxil-bellagio-dev \
#   libasound2-dev \
#   libass-dev \
#   libavcodec-dev \
#   libavdevice-dev \
#   libavfilter-dev \
#   libavformat-dev \
#   libavutil-dev \
#   libfreetype6-dev \
#   libgmp-dev \
#   libmp3lame-dev \
#   libopencore-amrnb-dev \
#   libopencore-amrwb-dev \
#   libopus-dev \
#   librtmp-dev \
#   libsdl2-dev \
#   libsdl2-image-dev \
#   libsdl2-mixer-dev \
#   libsdl2-net-dev \
#   libsdl2-ttf-dev \
#   libsnappy-dev \
#   libsoxr-dev \
#   libssh-dev \
#   libssl-dev \
#   libv4l-dev \
#   libva-dev \
#   libvdpau-dev \
#   libvo-amrwbenc-dev \
#   libvorbis-dev \
#   libwebp-dev \
#   libx264-dev \
#   libx265-dev \
#   libxcb-shape0-dev \
#   libxcb-shm0-dev \
#   libxcb-xfixes0-dev \
#   libxcb1-dev \
#   libxml2-dev \
#   lzma-dev \
#   python3-dev \
#   zlib1g-dev \
#   libdrm-dev \
# WORKDIR /root/
# RUN git clone https://github.com/FFmpeg/FFmpeg.git
# WORKDIR /root/FFmpeg

# RUN ./configure --arch=arm64 --target-os=linux --enable-gpl --enable-omx --enable-omx-rpi --enable-nonfree
# RUN make
# RUN make install

# CMD ["/bin/bash"]

FROM linuxserver/ffmpeg

RUN apt-get update && apt-get -qy install \
  libraspberrypi-bin && \
  rm -rf /var/lib/apt/lists/*

COPY entry.sh	/root/entry.sh

ENTRYPOINT ["/root/entry.sh"]
