FROM ubuntu:16.04

MOUNT quartus:/quartus

VAR QUARTUS_VERSION 18.1

WORKDIR /quartus
RUN ./QuartusStandardSetup-$(QUARTUS_VERSION)*.run --mode unattended
RUN ./SoCEDSSetup-$(QUARTUS_VERSION)*.run --mode unattended

# Quartus Requirements
RUN apt-get update && apt-get install -y \
        libglib2.0-0 \
        libpng12-0 \
        libfreetype6 \
        libsm6 \
        libxrender1 \
        libfontconfig1 \
        libxext6 \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

# DS-5 Requirements (in addition to quartus requirements)
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
        libasound2 \
        libatk1.0-0 \
        libcairo2 \
        libgl1-mesa-glx \
        libglu1-mesa \
        libgtk2.0-0 \
        libxi6 \
        libxt6 \
        libxtst6 \
        libc6:i386 \
        libfontconfig1:i386 \
        libfreetype6:i386 \
        libgl1-mesa-glx:i386 \
        libice6:i386 \
        libncurses5:i386 \
        libsm6:i386 \
        libstdc++6 \
        libusb-0.1-4:i386 \
        libxcursor1:i386 \
        libxft2:i386 \
        libxmu6:i386 \
        libxrandr2:i386 \
        libxrender1:i386 \
        libwebkitgtk-3.0-0 \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

# Install DS-5
WORKDIR /opt/intelFPGA/$(QUARTUS_VERSION)/embedded/ds-5_installer
RUN ./install.sh --i-agree-to-the-contained-eula --no-interactive

ENV PATH "$PATH:/opt/intelFPGA/$(QUARTUS_VERSION)/quartus/bin"
ENV PATH "$PATH:/usr/local/DS-5_v5.25.0/bin"
WORKDIR /home/ubuntu/
TAG quartus:QUARTUS_VERSION

ATTACH
