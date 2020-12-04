# Use Ubuntu 18.04 as base image

FROM ubuntu:18.04

# Install git

RUN apt-get update
RUN apt-get install -y git

# Get OP25 code

RUN git clone https://github.com/boatbod/op25.git

# Set working directory

WORKDIR /op25

# Pre-build tasks

RUN cp /etc/apt/sources.list /etc/apt/sources.list~
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

# Download OP25 Packages

RUN apt-get -y build-dep gnuradio
RUN apt-get -y install gnuradio gnuradio-dev gr-osmosdr librtlsdr-dev libuhd-dev libhackrf-dev libitpp-dev libpcap-dev cmake git swig build-essential pkg-config doxygen python-numpy python-waitress python-requests gnuplot-x11

# Check file

RUN if [[ ! -f /etc/modprobe.d/blacklist-rtl.conf ]]; then echo ====== installing blacklist-rtl.conf; echo ====== please reboot before running op25; install -m 0644 ./blacklist-rtl.conf /etc/modprobe.d/; fi

# Install OP25

RUN mkdir build
WORKDIR /op25/build
RUN cmake ../
RUN make
RUN make install
RUN ldconfig

WORKDIR /op25/op25/gr-op25_repeater/apps

CMD ["sh", "config/op25.sh"]
