FROM resin/rpi-raspbian:jessie

RUN apt-get update
RUN apt-get install autoconf build-essential git liblockdev1-dev libtool libudev-dev pkg-config cmake libudev-dev libxrandr-dev python-dev swig

WORKDIR /tmp
RUN git clone git://github.com/Pulse-Eight/platform.git
WORKDIR /tmp/platform
RUN mkdir build
WORKDIR /tmp/platform/build
RUN cmake ..
RUN make
RUN make install

WORKDIR /tmp
RUN git clone git://github.com/Pulse-Eight/libcec.git
WORKDIR /tmp/libcec
RUN git checkout f2c4ca7702d5ae0301c9648fee7cf5525b4e11db
RUN mkdir build
WORKDIR /tmp/libcec/build
RUN cmake -DRPI_INCLUDE_DIR=/opt/vc/include -DRPI_LIB_DIR=/opt/vc/lib ..
RUN make -j4
RUN make install
RUN ldconfig
