FROM kalilinux/kali-rolling:latest

# Update and install base Kali metapackage
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    kali-linux-default \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install additional required packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    vsftpd \
    hexedit \
    strongswan \
    libstrongswan-extra-plugins \
    dkms \
    lynx \
    s-nail \
    alien \
    nsis \
    httptunnel \
    net-tools \
    ettercap-common \
    ettercap-graphical \
    ptunnel \
    nmap \
    openssl \
    hashdeep \
    p7zip-full \
    apache2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /root

# Keep container running
CMD ["/bin/bash"]\
