FROM resin/rpi-raspbian:jessie

EXPOSE 5353 51826

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

# install dependencies
RUN apt-get update && apt-get install -y \
    wget build-essential curl git apt-transport-https python make g++ avahi-daemon avahi-discover libnss-mdns libavahi-compat-libdnssd-dev libkrb5-dev net-tools libpcap-dev

# install latest stable node 6
RUN wget --no-check-certificate -O - https://deb.nodesource.com/setup_6.x | bash && \
    apt-get install -y nodejs && \
    apt-get clean

# install homebridge
RUN npm install -g --unsafe-perm homebridge hap-nodejs node-gyp

# install homebridge plugin dependencies
RUN curl -O https://github.com/legotheboss/YouTube-files/raw/master/ffmpeg_3.1.4-1_armhf.deb
RUN dpkg -i ffmpeg_3.1.4-1_armhf.deb

# install homebridge plugins
RUN npm install -g homebridge-nest --unsafe-perm
RUN npm install -g https://github.com/rcreasey/homebridge-garage-sentry.git --unsafe-perm
RUN npm install -g homebridge-platform-ring-video-doorbell
RUN npm install -g homebridge-camera-ffmpeg-omx

USER root
VOLUME ["/root/.homebridge"]
RUN mkdir -p /var/run/dbus

COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh
CMD ["/root/run.sh"]
