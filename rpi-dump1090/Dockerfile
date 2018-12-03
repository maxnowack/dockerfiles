FROM resin/rpi-raspbian:stretch

RUN apt-get update && \
    apt-get install -y libusb-1.0-0-dev pkg-config ca-certificates git-core cmake build-essential --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN wget https://github.com/mutability/librtlsdr/releases/download/v0.5.4_git-1/librtlsdr0_0.5.4.git-1_armhf.deb

WORKDIR /tmp/dump1090

RUN apt-get install -y pkg-config && \
    apt-get clean

RUN make

ENTRYPOINT ["./dump1090"]
