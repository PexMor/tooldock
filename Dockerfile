FROM ubuntu:latest

MAINTAINER Petr Moravek v1.1

ARG BA_UID=1000
ARG BA_GID=1000
ARG BA_TZ=Europe/Prague

# Set correct environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV container docker
ENV init /lib/systemd/systemd
ENV COLUMNS 80
ENV LINES 24
ENV TERM xterm-256color
ENV PXL_VER 1.0
ENV X_UID=$BA_UID
ENV X_GID=$BA_GID
ENV X_TZ="$BA_TZ"

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
      tzdata \
      certmonger \
      sudo \
      easy-rsa \
      openvpn \
      python3 \
      bridge-utils \
      inetutils-ping \
      tcpdump \
      xl2tpd \
      strongswan \
      squid \
      arping \
      virtualenv \
      python3-dev \
      openconnect \
      net-tools \
      curl \
      tmux \
      psutils \
      psmisc \
      whois \
      mc \
      jq \
      ssh \
      dnsutils \
      avahi-daemon \
      avahi-utils \
      openvswitch-switch \
      openvswitch-vtep \
      openvswitch-pki \
      openssl libnss3-tools \
      iperf \
      dnsmasq \
      udhcpc \
      locales && \
    locale-gen en_US.UTF-8 && \
    apt-get -qq upgrade && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN ( groupadd --gid $X_GID user || exit 0 ) && \
    useradd --uid $X_UID -M --home-dir /home --shell /bin/bash -g $X_GID user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    dbus-uuidgen > /var/lib/dbus/machine-id && \
    ln -sf /usr/share/zoneinfo/$X_TZ /etc/localtime

COPY loopForEver /usr/local/bin/loopForEver
COPY system.conf /etc/dbus-1/system.conf

ENV HOME /home
ENV PATH="/usr/share/easy-rsa:${PATH}"
WORKDIR /home
USER user

ENTRYPOINT [ "/usr/local/bin/loopForEver" ]
